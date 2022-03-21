# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      module DB
        class Seed < Base
          def process(*args)
            seed_filepath = Jun.root.join("db/seed.rb")
            abort("No seed file found.") unless File.exist?(seed_filepath)

            load seed_filepath
            puts "Seeding complete."
          end
        end
      end
    end
  end
end
