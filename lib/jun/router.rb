# frozen_string_literal: true

module Jun
  class Router
    def initialize(env)
      @env = env
    end

    def controller_class
      prefix = path_info[:controller].capitalize
      controller_class_name = "#{prefix}Controller"

      Object.const_get(controller_class_name)
    end

    def controller_action
      path_info[:action]
    end

    private

    def path_info
      return @path_info if defined?(@path_info)

      _, controller, action, after = @env["PATH_INFO"].split("/", 4)

      @path_info = { controller: controller, action: action }
    end
  end
end
