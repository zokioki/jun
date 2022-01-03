# frozen_string_literal: true

require "erubi"
require "json"

module Jun
  module ActionController
    class ViewContext; end

    module Rendering
      def render(options, extra_options = {})
        return if response_rendered?

        template_name = nil
        if options.is_a?(Symbol) || options.is_a?(String)
          template_name = options
          options = extra_options
        else
          template_name = options[:template]
        end

        if content_type = options[:content_type]
          response.content_type = content_type.to_s
        end

        if status = options[:status]
          response.status = status
        end

        if template_name
          filepath = views_path.join("#{template_name}.html.erb")
          template = File.read(filepath)
          erubi = Erubi::Engine.new(template)
          context = Jun::ActionController::ViewContext.new

          instance_variables.each do |var_name|
            context.instance_variable_set(var_name, instance_variable_get(var_name))
          end

          body = context.instance_eval(erubi.src)

          response.write(body)
          response.content_type ||= "text/html"
        elsif options[:text]
          response.write(options[:text])
          response.content_type ||= "text/plain"
        elsif options[:json]
          json = options[:json].is_a?(String) ? options[:json] : JSON.generate(options[:json])
          response.write(json)
          response.content_type ||= "application/json"
        elsif options[:nothing]
          response.write("")
          response.content_type ||= "text/plain"
        end

        @_response_rendered = true
      end

      private

      def response_rendered?
        !!@_response_rendered
      end

      def views_path
        dirname = self.class.name.sub(/Controller\z/, "").underscore
        Jun.root.join("app/views/#{dirname}")
      end
    end
  end
end
