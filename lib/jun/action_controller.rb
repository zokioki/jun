# frozen_string_literal: true

require "erubis"

module Jun
  module ActionController
    class Base
      attr_reader :env

      def initialize(env)
        @env = env
      end

      def render(view_name, locals: nil)
        filepath = views_path.join("#{view_name}.html.erb")
        template = File.read(filepath)
        eruby = Erubis::Eruby.new(template)

        if locals
          eruby.result(locals.merge(env: env))
        else
          vars_for_view = {}

          instance_variables.each do |var_name|
            vars_for_view[var_name[1..-1]] = instance_variable_get(var_name)
          end

          eruby.evaluate(vars_for_view)
        end
      end

      private

      def views_path
        dirname = self.class.name.sub(/Controller\z/, "").underscore
        Jun.root.join("app/views/#{dirname}")
      end
    end
  end
end
