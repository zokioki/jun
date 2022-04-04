# frozen_string_literal: true

module Jun
  module ActiveSupport
    module Dependencies
      extend self

      attr_accessor :autoload_paths
      self.autoload_paths = []

      # Returns the filepath for a given filename if the file exists
      # in one of the directories specified in +autoload_paths+.
      def find_file(filename)
        autoload_paths.each do |path|
          filepath = File.join(path, "#{filename}.rb")
          return filepath if File.file?(filepath)
        end

        nil
      end
    end
  end
end

class Object
  def self.const_missing(constant_name)
    file = Jun::ActiveSupport::Dependencies.find_file(constant_name.to_s.underscore)
    super if file.nil?

    require file.sub(/\.rb\z/, "")
    Object.const_get(constant_name)
  end
end
