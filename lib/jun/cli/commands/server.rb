# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      class Server < Base
        def process(*args)
          if Jun.root
            system("rerun --background -- rackup -p 3001")
          else
            abort("Command \"#{self.class.command_name}\" must be run inside of a Jun app.")
          end
        end
      end
    end
  end
end
