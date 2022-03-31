# frozen_string_literal: true

class Hash
  def stringify_keys
    transform_keys(&:to_s)
  end

  def stringify_keys!
    transform_keys!(&:to_s)
  end

  def symbolize_keys
    transform_keys { |key| key.to_sym rescue key }
  end

  def symbolize_keys!
    transform_keys! { |key| key.to_sym rescue key }
  end
end
