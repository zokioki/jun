# frozen_string_literal: true

require_relative "jun/version"
require_relative "jun/active_record"

module Jun
  class Application
    def call(env)
      [
        200,
        { "Content-Type" => "text/html" },
        ["You're running Jun v#{Jun::VERSION}"]
      ]
    end
  end
end
