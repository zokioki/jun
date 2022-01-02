# frozen_string_literal: true

require_relative "rendering"

module Jun
  module ActionController
    class Base
      include Jun::ActionController::Rendering

      attr_reader :env

      def initialize(env)
        @env = env
      end

      def request
        @request ||= Rack::Request.new(env)
      end

      def response
        @response ||= Rack::Response.new
      end

      def handle_response(action)
        public_send(action)
        render(action) unless response_rendered?

        response
      end
    end
  end
end
