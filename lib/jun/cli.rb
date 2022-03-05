# frozen_string_literal: true

module Jun
  module CLI
    class << self
      COMMAND_MAP = {
        "new" => :create_new_app,
        "db:create" => :create_database,
        "db:migrate" => :run_migrations,
        "db:drop" => :drop_database,
        "version" => :version_label
      }.freeze

      def process_command(argv)
        arg = argv.first
        command = COMMAND_MAP[arg]
        return if command.nil?

        send(command)
      end

      private

      def version_label
        puts "Jun #{Jun::VERSION}"
      end

      def create_new_app
        if Jun.root
          puts "Already in a Jun app..."
        else
          puts "Creating new app..."
        end
      end

      def create_database
        puts "Creating db..."
      end

      def run_migrations
        puts "Running migrations..."
      end

      def drop_database
        puts "Dropping database..."
      end
    end
  end
end
