# frozen_string_literal: true

require_relative "helpers"

module Jun
  module ActionView
    class Base
      include Jun::ActionView::Helpers

      attr_reader :controller

      def initialize(controller)
        @controller = controller
        assign_instance_variables
      end

      private

      def assign_instance_variables
        controller.view_assigns.each do |name, value|
          instance_variable_set("@#{name}", value)
        end
      end
    end
  end
end
