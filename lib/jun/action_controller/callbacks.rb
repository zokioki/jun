# frozen_string_literal: true

module Jun
  module ActionController
    module Callbacks
      def self.included(base)
        base.extend ClassMethods
      end

      def handle_response(action)
        self.class.before_actions.each do |callback|
          callback.call(self) if callback.match?(action)
        end

        super
      end

      module ClassMethods
        def before_action(method_name, options = {})
          before_actions << Callback.new(method_name, options)
        end

        def before_actions
          @before_actions ||= []
        end
      end

      class Callback
        def initialize(method_name, options)
          @method_name = method_name
          @options = options
        end

        def match?(action)
          return true unless @options[:only]&.any?

          @options[:only].include?(action.to_sym)
        end

        def call(controller)
          controller.send(@method_name)
        end
      end
    end
  end
end
