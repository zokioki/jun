# frozen_string_literal: true

class Object
  def self.const_missing(constant)
    require constant.to_s.underscore
    Object.const_get(constant)
  end
end
