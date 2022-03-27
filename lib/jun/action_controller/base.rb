# frozen_string_literal: true

require_relative 'metal'
require_relative 'callbacks'
require_relative "rendering"
require_relative "redirecting"

module Jun
  module ActionController
    class Base < Metal
      include Jun::ActionController::Callbacks
      include Jun::ActionController::Rendering
      include Jun::ActionController::Redirecting
    end
  end
end
