# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      module DB
        class Create < Base
          def process(*args)
            db_filepath = Jun.root.join("db/app.db")

            if File.exist?(db_filepath)
              puts "Database already exists."
            else
              File.open(db_filepath, "w") {}
              create_schema_migrations_table
              puts "Created database in #{db_filepath}."
            end
          end

          private

          def create_schema_migrations_table
            ActiveRecord::Base.connection.execute(
              <<~SQL
                CREATE TABLE IF NOT EXISTS schema_migrations (
                  version text NOT NULL PRIMARY KEY
                );"
              SQL
            )
          end
        end
      end
    end
  end
end
