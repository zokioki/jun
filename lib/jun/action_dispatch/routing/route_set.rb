# frozen_string_literal: true

require_relative "mapper"

module Jun
  module ActionDispatch
    module Routing
      class Route < Struct.new(:method, :path, :controller, :action, :name)
        def match?(request)
          request.request_method == method && path_regex.match?(request.path_info)
        end

        def path_regex
          path_string_for_regex = path.gsub(/:\w+/) { |match| "(?<#{match.delete(":")}>\\w+)" }
          Regexp.new(path_string_for_regex)
        end
      end

      class RouteSet
        def initialize
          @routes = []
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
      end
    end
  end
end
