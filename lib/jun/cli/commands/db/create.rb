# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      module DB
        class Create < Base
          def process(*args)
            puts "Creating database..."
          end
        end
      end
    end
  end
end
