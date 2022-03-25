# frozen_string_literal: true

Dir[File.expand_path("cli/commands/**/*.rb", __dir__)].each do |filepath|
  require_relative filepath
end

module Jun
  module CLI
    class << self
      COMMAND_KLASSES = [
        Jun::CLI::Commands::New,
        Jun::CLI::Commands::DB::Create,
        Jun::CLI::Commands::DB::Migrate,
        Jun::CLI::Commands::DB::Rollback,
        Jun::CLI::Commands::DB::Seed,
        Jun::CLI::Commands::DB::Drop,
        Jun::CLI::Commands::DB::Schema::Dump,
        Jun::CLI::Commands::DB::Schema::Load,
        Jun::CLI::Commands::Generate::Migration,
        Jun::CLI::Commands::Server,
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
