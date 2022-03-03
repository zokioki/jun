# frozen_string_literal: true

module Jun
  module CLI
    class << self
      def process_command(argv)
        arg = argv.first

        if arg == "version"
          puts version_label
        elsif arg == "new"
          create_new_app
        end
      end

      private

      def version_label
        "Jun #{Jun::VERSION}"
      end

      def create_new_app
        if Jun.root
          puts "Already in a Jun app..."
        else
          puts "Creating new app..."
        end
      end
    end
  end
end
