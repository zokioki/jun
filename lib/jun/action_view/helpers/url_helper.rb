# frozen_string_literal: true

module Jun
  module ActionView
    module Helpers
      module UrlHelper
        def link_to(title, url, options = {})
          %Q{<a href="#{url}"#{ "class=\"#{options[:class]}\"" if options[:class] }>#{title}</a>}
        end
      end
    end
  end
end
