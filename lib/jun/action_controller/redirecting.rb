# frozen_string_literal: true

module Jun
  module ActionController
    module Redirecting
      def redirect_to(location, options = {})
        return if response_rendered?

        response.location = location
        response.status = options[:status] || 302
        response.write("<html><body>You are being <a href=\"#{response.location}\">redirected</a>.</body></html>")

        @_response_rendered = true
      end
    end
  end
end
