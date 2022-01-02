# frozen_string_literal: true

require_relative "jun/version"
require_relative "jun/support/inflector"
require_relative "jun/dependencies"
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
      response = controller.public_send(action)

      [
        200,
        { "Content-Type" => "text/html" },
        [response]
      ]
    end
  end
end
