# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      class Base
        def self.command_name
          name.sub("Jun::CLI::Commands::", "").underscore.gsub("/", ":")
        end

        def process(*args)
          raise NoMethodError, "Subclass must implement method."
        end
      end
    end
  end
end
