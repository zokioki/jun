# frozen_string_literal: true

require_relative "mapper"
require_relative "url_helpers"

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
            not_found_response
          end
        end

        def add_route(*args)
          route = Route.new(*args)
          @routes.push(route)
          define_url_helper(route)

          route
        end

        def find_route(request)
          @routes.detect { |route| route.match?(request) }
        end

        def draw(&block)
          mapper = Jun::ActionDispatch::Routing::Mapper.new(self)
          mapper.instance_eval(&block)
        end

        def url_helpers
          @url_helpers ||= Module.new { extend url_helpers_module }
        end

        private

        def url_helpers_module
          Jun::ActionDispatch::Routing::UrlHelpers
        end

        def define_url_helper(route)
          path_name = "#{route.name}_path"

          url_helpers_module.define_method(path_name) do |*args|
            options = args.last.is_a?(Hash) ? args.pop : {}
            path = route.path
            path_tokens = path.scan(/:\w+/)

            path_tokens.each.with_index do |token, index|
              path.sub!(token, args[index])
            end

            path
          end
        end

        def not_found_response
          response = Rack::Response.new
          response.content_type = "text/plain"
          response.status = 404
          response.write("Not found")
          response.finish
        end

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
