# frozen_string_literal: true

module Jun
  module ActionController
    class Base
      attr_reader :env

      def initialize(env)
        @env = env
      end
    end
  end
end
