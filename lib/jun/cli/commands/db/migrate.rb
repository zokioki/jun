# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      module DB
        class Migrate < Base
          def process(*args)
            puts "Running migrations..."
          end
        end
      end
    end
  end
end
