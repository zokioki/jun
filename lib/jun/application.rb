# frozen_string_literal: true

module Jun
  class Application
    def call(env)
      router = Jun::Router.new(env)
      controller = router.controller_class.new(env)
      action = router.controller_action
      response = controller.handle_response(action)

      response.finish
    end
  end
end