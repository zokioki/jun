# frozen_string_literal: true

module Jun
  module ActionDispatch
    module Routing
      class Mapper
        def initialize(route_set)
          @route_set = route_set
        end

        def get(path, to:, as: nil)
          add_route(:get, path, to: to, as: as)
        end

        def post(path, to:, as: nil)
          add_route(:post, path, to: to, as: as)
        end

        def patch(path, to:, as: nil)
          add_route(:patch, path, to: to, as: as)
        end

        def delete(path, to:, as: nil)
          add_route(:delete, path, to: to, as: as)
        end

        def root(to:)
          get "/", to: to, as: "root"
        end

        def resources(plural_name)
          get "/#{plural_name}", to: "#{plural_name}#index", as: plural_name.to_s
          get "/#{plural_name}/new", to: "#{plural_name}#new", as: "new_#{plural_name.to_s.singularize}"
          post "/#{plural_name}", to: "#{plural_name}#create"
          get "/#{plural_name}/:id", to: "#{plural_name}#show", as: plural_name.to_s.singularize
          get "/#{plural_name}/:id/edit", to: "#{plural_name}#edit", as: "edit_#{plural_name.to_s.singularize}"
          patch "/#{plural_name}/:id", to: "#{plural_name}#update"
          delete "/#{plural_name}/:id", to: "#{plural_name}#destroy"
        end

        private

        def add_route(method, path, to:, as: nil)
          method = method.to_s.upcase
          controller, action = to.split("#")
          path = path.to_s.start_with?("/") ? path.to_s : "/#{path}"
          as ||= path.sub("/", "")

          @route_set.add_route(method, path, controller, action, as)
        end
      end
    end
  end
end
