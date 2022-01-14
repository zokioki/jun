# frozen_string_literal: true

module Jun
  class Application
    def self.inherited(subclass)
      super
      Jun.app_class = subclass
    end

    def call(env)
      routes.call(env)
    end

    def routes
      @routes ||= Jun::ActionDispatch::Routing::RouteSet.new
    end
  end
end
