# frozen_string_literal: true

require "pathname"

require_relative "jun/version"
require_relative "jun/active_support/inflector"
require_relative "jun/active_support/dependencies"
require_relative "jun/action_dispatch/routing/route_set"
require_relative "jun/active_record/base"
require_relative "jun/active_record/migration"
require_relative "jun/action_controller/base"
require_relative "jun/application"

module Jun
  class << self
    attr_accessor :app_class

    def application
      @application ||= app_class&.new
    end

    def root
      project_root_path
    end

    private

    def project_root_path
      current_dir = Dir.pwd
      root_file = "config.ru"

      while current_dir && File.directory?(current_dir) && !File.exist?("#{current_dir}/#{root_file}")
        parent_dir = File.dirname(current_dir)
        current_dir = parent_dir != current_dir && parent_dir
      end

      root_dir = current_dir if File.exist?("#{current_dir}/#{root_file}")
      return if root_dir.nil?

      Pathname.new(File.realpath(root_dir))
    end
  end
end
