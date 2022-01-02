# frozen_string_literal: true

require "erubis"

module Jun
  module ActionController
    class Base
      attr_reader :env

      def initialize(env)
        @env = env
      end

      def render(view_name, locals = {})
        filepath = views_path.join("#{view_name}.html.erb")
        template = File.read(filepath)
        eruby = Erubis::Eruby.new(template)

        eruby.result(locals.merge(_env: env))
      end

      private

      def views_path
        dirname = self.class.name.sub(/Controller\z/, "").underscore
        Jun.root.join("app/views/#{dirname}")
      end
    end
  end
end
