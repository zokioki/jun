# frozen_string_literal: true

module ActiveRecord
  class Migrator
    ALLOWED_DIRECTIONS = %w[up down].freeze

    def initialize(direction:)
      unless ALLOWED_DIRECTIONS.include?(direction.to_s)
        raise ArgumentError, "direction must be one of: #{ALLOWED_DIRECTIONS.inspect}"
      end

      @direction = direction.to_s
    end

    def call
      process_migrations!
    end

    private

    def process_migrations!
      files_to_process = up_migration? ? pending_migration_files : processed_migration_files.last(1)

      files_to_process.each do |filepath|
        require filepath

        filename = filepath.split("/").last.sub(".rb", "")
        migration_version = filename.split("_").first
        migration_class_name = filename.split("_", 2).last.camelize
        migration_class = Object.const_get(migration_class_name)

        migration_class.new.public_send(@direction)
        up_migration? ? add_to_schema_migrations(migration_version) :
                        remove_from_schema_migrations(migration_version)

        migration_verb = up_migration? ? "processed" : "rolled back"
        puts "Migration #{migration_verb} (#{filename})."
      end

      dump_schema! if files_to_process.any?
    end

    def up_migration?
      @direction == "up"
    end

    def pending_migration_files
      @pending_migration_files ||= migration_files - processed_migration_files
    end

    def processed_migration_files
      @processed_migration_files ||= migration_files.select do |filepath|
        file_version = filepath.split("/").last.split("_").first
        processed_versions.include?(file_version)
      end
    end

    def migration_files
      @migration_files ||= Dir.glob(Jun.root.join("db/migrate/*.rb")).sort
    end

    def processed_versions
      ActiveRecord::Base.connection.execute("SELECT * FROM schema_migrations;").map do |attributes|
        attributes[:version]
      end
    end

    def add_to_schema_migrations(version)
      ActiveRecord::Base.connection.execute("INSERT INTO schema_migrations (version) VALUES (#{version});")
    end

    def remove_from_schema_migrations(version)
      ActiveRecord::Base.connection.execute("DELETE FROM schema_migrations WHERE version = #{version};")
    end

    def dump_schema!
      Jun::CLI.process_command(["db:schema:dump"])
    end
  end
end
