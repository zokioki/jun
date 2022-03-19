# frozen_string_literal: true

require_relative "mapper"

module Jun
  module ActionDispatch
    module Routing
      class Route < Struct.new(:method, :path, :controller, :action, :name)
        def match?(request)
          request.request_method == method && path_regex.match?(request.path_info)
        end

        def dispatch(request)
          controller = controller_class.new
          controller.request = request
          controller.response = Rack::Response.new
          controller.handle_response(action)
          controller.response.finish
        end

        def controller_class
          class_name = "#{controller.camelize}Controller"
          Object.const_get(class_name)
        end

        def path_regex
          path_string_for_regex = path.gsub(/:\w+/) { |match| "(?<#{match.delete(":")}>\\w+)" }
          Regexp.new("^#{path_string_for_regex}$")
        end
      end

      class RouteSet
        def initialize
          @routes = []
        end

        def call(env)
          return welcome_response if @routes.none?

          request = Rack::Request.new(env)

          if route = find_route(request)
            route.dispatch(request)
          else
            [404, { "Content-Type" => "text/plain" }, ["Not found"]]
          end
        end

        def add_route(*args)
          route = Route.new(*args)
          @routes.push(route)

          route
        end

        def find_route(request)
          @routes.detect { |route| route.match?(request) }
        end

        def draw(&block)
          mapper = Jun::ActionDispatch::Routing::Mapper.new(self)
          mapper.instance_eval(&block)
        end

        private

        def welcome_response
          template_filepath = File.expand_path("welcome.html.erb", __dir__)
          template = Tilt::ERBTemplate.new(template_filepath)

          response = Rack::Response.new
          response.content_type = "text/html"
          response.write(template.render)
          response.finish
        end
      end
    end
  end
end
