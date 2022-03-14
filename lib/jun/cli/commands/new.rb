# frozen_string_literal: true

require 'fileutils'

module Jun
  module CLI
    module Commands
      class New < Base
        def process(*args)
          if Jun.root
            puts "Already in a Jun app..."
          else
            generate_new_app(args.first)
          end
        end

        private

        def generate_new_app(app_name)
          puts "Creating new app..."

          templates = [
            "config.ru",
            "Gemfile",
            "README.md",
            "app/controllers/application_controller.rb",
            "app/helpers/application_helper.rb",
            "app/views/layouts/application.html.erb",
            "config/application.rb",
            "config/routes.rb",
            "db/app.db"
          ]

          Dir.mkdir(app_name) unless Dir.exists?(app_name)

          Dir.chdir(app_name) do
            templates.each do |filepath|
              template_filepath = File.expand_path("../generators/new/#{filepath}.erb", __dir__)
              template = Tilt::ERBTemplate.new(template_filepath)
              template_locals = { app_name: app_name }
              file_body = template.render(nil, template_locals)

              FileUtils.mkdir_p(File.dirname(filepath))

              File.open(filepath, "w") { |f| f.write(file_body) }
              puts "created #{filepath}"
            end
          end
        end
      end
    end
  end
end
