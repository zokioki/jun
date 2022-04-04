# frozen_string_literal: true

class Hash
  # Returns a new hash with all keys converted to strings.
  #
  #   { name: "Tom", age: 50 }.stringify_keys #=> {"name"=>"Tom", "age"=>50}
  def stringify_keys
    transform_keys(&:to_s)
  end

  # Modifies the hash in place to convert all keys to strings.
  # Same as +stringify_keys+ but modifies +self+.
  def stringify_keys!
    transform_keys!(&:to_s)
  end

  # Returns a new hash with all keys converted to symbols.
  #
  #   { "name" => "Tom", "age" => 50 }.symbolize_keys #=> {:name=>"Tom", :age=>50 }
  def symbolize_keys
    transform_keys { |key| key.to_sym rescue key }
  end

  # Modifies the hash in place to convert all keys to symbols.
  # Same as +symbolize_keys+ but modifies +self+.
  def symbolize_keys!
    transform_keys! { |key| key.to_sym rescue key }
  end
end
