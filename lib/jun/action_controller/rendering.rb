# frozen_string_literal: true

require "tilt/erb"
require "json"

require_relative "../action_view/base"

module Jun
  module ActionController
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

        options[:layout] = true unless options.key?(:layout)

        if content_type = options[:content_type]
          response.content_type = content_type.to_s
        end

        if status = options[:status]
          response.status = status
        end

        if template_name
          filepath = views_path.join("#{template_name}.html.erb")
          template = Tilt::ERBTemplate.new(filepath)
          context = Jun::ActionView::Base.new(self)
          body = template.render(context, options[:locals])

          if options[:layout]
            layout_name = options[:layout].is_a?(String) ? options[:layout] : "application"
            layout_filepath = layouts_path.join("#{layout_name}.html.erb")
            layout_template = Tilt::ERBTemplate.new(layout_filepath)

            body = layout_template.render(context) { body }
          end

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

      def view_assigns
        reserved_variables = %i[@request @response @_response_rendered]
        variables = instance_variables - reserved_variables

        variables.reduce({}) do |object, name|
          object.merge(name[1..-1] => instance_variable_get(name))
        end
      end

      private

      def views_path
        dirname = self.class.name.sub(/Controller\z/, "").underscore
        Jun.root.join("app/views/#{dirname}")
      end

      def layouts_path
        Jun.root.join("app/views/layouts")
      end
    end
  end
end
