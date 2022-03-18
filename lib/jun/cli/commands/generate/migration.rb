# frozen_string_literal: true

module Jun
  module CLI
    module Commands
      module Generate
        class Migration < Base
          def process(*args)
            migration_name = args.first

            template_filepath = File.expand_path("../../generator_templates/migration.rb.erb", __dir__)
            template = Tilt::ERBTemplate.new(template_filepath)
            template_locals = { migration_name: migration_name }

            filename = "#{Time.now.to_i}_#{migration_name}.rb"
            filepath = Jun.root.join("db/migrate/#{filename}")
            file_body = template.render(nil, template_locals)

            File.open(filepath, "w") { |f| f.write(file_body) }
            puts "created #{filename}"
          end
        end
      end
    end
  end
end
