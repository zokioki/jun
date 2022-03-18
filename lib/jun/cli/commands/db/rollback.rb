# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      module DB
        class Rollback < Base
          def process(*args)
            ActiveRecord::Migrator.new(direction: :down).call
          end
        end
      end
    end
  end
end
