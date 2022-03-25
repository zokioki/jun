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

              puts "Database schema loaded."
            end
          end
        end
      end
    end
  end
end
