# frozen_string_literal: true

require "erubis"

module Jun
  module ActionController
    class Base
      attr_reader :env

      def initialize(env)
        @env = env
      end

      def render(options, extra_options = {})
        return if @_response_rendered

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
          eruby = Erubis::Eruby.new(template)

          body = if options[:locals]
                   eruby.result(options[:locals].merge(env: env))
                 else
                   vars_for_view = {}

                   instance_variables.each do |var_name|
                     vars_for_view[var_name[1..-1]] = instance_variable_get(var_name)
                   end

                   eruby.evaluate(vars_for_view)
                 end

          response.write(body)
          response.content_type ||= "text/html"
        elsif options[:text]
          response.write(options[:text])
          response.content_type ||= "text/plain"
        end

        @_response_rendered = true
      end

      def request
        @request ||= Rack::Request.new(env)
      end

      def response
        @response ||= Rack::Response.new
      end

      def handle_response(action)
        public_send(action)
        render(action) unless @_response_rendered

        response
      end

      private

      def views_path
        dirname = self.class.name.sub(/Controller\z/, "").underscore
        Jun.root.join("app/views/#{dirname}")
      end
    end
  end
end
