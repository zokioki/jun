# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      module DB
        class Drop < Base
          def process(*args)
            puts "Dropping database..."
          end
        end
      end
    end
  end
end
