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
              puts "Created database in #{db_filepath}."
            end
          end
        end
      end
    end
  end
end
