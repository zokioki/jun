# frozen_string_literal: true

Dir.glob(File.join("./lib/jun/cli/commands", "**", "*.rb"), &method(:require))

module Jun
  module CLI
    class << self
      COMMAND_KLASSES = [
        Jun::CLI::Commands::New,
        Jun::CLI::Commands::DB::Create,
        Jun::CLI::Commands::DB::Migrate,
        Jun::CLI::Commands::DB::Drop,
        Jun::CLI::Commands::Version
      ].freeze

      def process_command(argv)
        command_name = argv.shift
        command_klass = COMMAND_KLASSES.find { |klass| klass.command_name == command_name }
        abort("Command \"#{command_name}\" not found.") if command_klass.nil?

        command_klass.new.process(*argv)
      end
    end
  end
end
