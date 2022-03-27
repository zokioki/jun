# frozen_string_literal: true

module Jun
  module ActionDispatch
    module Routing
      module UrlHelpers
        # This module will have its methods dynamically
        # defined as routes are added to RouteSet.
        #
        # TODO: Should be able to get rid of this module
        # as the helpers can be defined on an anonymous Module
        # and included in the base controller on Jun initialization.
      end
    end
  end
end
