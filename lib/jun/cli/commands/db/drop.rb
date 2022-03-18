# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      module DB
        class Drop < Base
          def process(*args)
            db_filepath = Jun.root.join("db/app.db")

            File.delete(db_filepath) if File.exist?(db_filepath)
            puts "Dropped database."
          end
        end
      end
    end
  end
end
