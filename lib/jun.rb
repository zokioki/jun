# frozen_string_literal: true

require "pathname"

require_relative "jun/version"
require_relative "jun/active_support/inflector"
require_relative "jun/active_support/dependencies"
require_relative "jun/active_record"
require_relative "jun/action_controller/base"
require_relative "jun/application"
require_relative "jun/router"

module Jun
  ROOT = Dir.pwd

  class << self
    attr_accessor :app_class

    def application
      @application ||= app_class&.new
    end

    def root
      Pathname.new(ROOT)
    end
  end
end
