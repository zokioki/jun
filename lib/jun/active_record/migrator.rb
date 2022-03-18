# frozen_string_literal: true

module ActiveRecord
  class Migrator
    def initialize(direction:)
      @direction = %w[up down].include?(direction.to_s) ? direction.to_s : "up"
    end

    def call
      @direction == "up" ? process_migrations : process_rollback
    end

    private

    def process_migrations
      pending_migration_files.each do |filepath|
        require filepath

        filename = filepath.split("/").last.sub(".rb", "")
        migration_version = filename.split("_").first
        migration_class_name = filename.split("_", 2).last.camelize
        migration_class = Object.const_get(migration_class_name)

        migration_class.new.up
        add_to_schema_migrations(migration_version)

        puts "Migration processed (#{filename})."
      end
    end

    def process_rollback
      filepath = processed_migration_files.last
      return if filepath.nil?

      require filepath

      filename = filepath.split("/").last.sub(".rb", "")
      migration_version = filename.split("_").first
      migration_class_name = filename.split("_", 2).last.camelize
      migration_class = Object.const_get(migration_class_name)

      migration_class.new.down
      remove_from_schema_migrations(migration_version)

      puts "Migration rolled back (#{filename})."
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
  end
end
