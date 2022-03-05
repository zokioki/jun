# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      class Version < Base
        def process(*args)
          puts "Jun #{Jun::VERSION}"
        end
      end
    end
  end
end
