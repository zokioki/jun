# frozen_string_literal: true

require "pathname"

require_relative "jun/version"
require_relative "jun/support/inflector"
require_relative "jun/support/dependencies"
require_relative "jun/active_record"
require_relative "jun/action_controller"
require_relative "jun/router"

module Jun
  ROOT = Dir.pwd

  def self.root
    Pathname.new(ROOT)
  end

  class Application
    def call(env)
      router = Jun::Router.new(env)
      controller = router.controller_class.new(env)
      action = router.controller_action
      response = controller.handle_response(action)

      [response.status, response.headers, [response.body].flatten]
    end
  end
end
