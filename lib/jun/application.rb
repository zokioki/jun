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

    def initialize!
      return false if initialized? || Jun.application.nil?

      # Add app/* directories to autoload paths.
      Jun::ActiveSupport::Dependencies.autoload_paths += Jun.root.join("app").children

      # Include all helpers in app/helpers directory.
      Dir.glob(Jun.root.join("app/helpers/**/*.rb")).each do |filepath|
        helper_class_name = File.basename(filepath, ".rb").camelize
        helper_class = Object.const_get(helper_class_name)

        Jun::ActionView::Base.include(helper_class)
      end

      @initialized = true
    end

    def initialized?
      !!@initialized
    end
  end
end
