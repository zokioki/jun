# frozen_string_literal: true

class String
  # Returns a character at the given integer of the string. The first character
  # would be returned for index 0, the second at index 1, and onward. If a range
  # is given, a substring conaining the characters within the range of the given
  # indicies is returned. If a Regex is provided, the matching substring is returned.
  #
  #   string = "smoki"
  #   string.at(0)      # => "s"
  #   string.at(1..3)   # => "mok"
  #   string.at(-2)     # => "k"
  #   string.at(/oki/)  # => "oki"
  def at(position)
    self[position]
  end

  # Returns a substring from the given position (index) to the end of the string.
  # If the position is negative, the starting point is counted from the end of the string.
  #
  #   string = "smoki"
  #   string.from(0)  # => "smoki"
  #   string.from(3)  # => "ki"
  #   string.from(-2) # => "ki"
  def from(position)
    self[position, length]
  end

  # Returns a substring from the beginning of the string to the given position (index).
  # If the position is negative, the ending point is counted from the end of the string.
  #
  #   string = "smoki"
  #   string.to(0)  # => "s"
  #   string.to(3)  # => "smok"
  #   string.to(-2) # => "smok"
  def to(position)
    position += size if position.negative?
    position = -1 if position.negative?

    self[0, position + 1]
  end
end
