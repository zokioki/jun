# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      class New < Base
        def process(*args)
          if Jun.root
            puts "Already in a Jun app..."
          else
            puts "Creating new app..."
          end
        end
      end
    end
  end
end
