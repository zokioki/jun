# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      module DB
        class Migrate < Base
          def process(*args)
            ActiveRecord::Migrator.new(direction: :up).call
          end
        end
      end
    end
  end
end
