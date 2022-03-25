# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      module DB
        module Schema
          class Load < Base
            def process(*args)
              schema_filepath = Jun.root.join("db/schema.sql")
              db_filepath = Jun.root.join("db/app.db")

              Bundler.with_original_env do
                system("bundle exec sqlite3 #{db_filepath} < #{schema_filepath}")
              end

              populate_schema_migrations!

              puts "Database schema loaded."
            end

            private

            def populate_schema_migrations!
              migration_files = Dir.glob(Jun.root.join("db/migrate/*.rb")).sort

              migration_files.each do |filepath|
                filename = filepath.split("/").last.sub(".rb", "")
                migration_version = filename.split("_").first

                add_to_schema_migrations(migration_version)
              end
            end

            def add_to_schema_migrations(version)
              ActiveRecord::Base.connection.execute("INSERT INTO schema_migrations (version) VALUES (#{version});")
            end
          end
        end
      end
    end
  end
end
