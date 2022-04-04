# frozen_string_literal: true

class Array
  # Converts the array to a comma-separated sentence.
  #
  #   ["one", "two", "three"].to_sentence                 #=> "one, two and three"
  #   ["left", "right"].to_sentence(last_delimiter: "or") #=> "left or right"
  #   [].to_sentence                                      #=> ""
  #
  # @param delimiter [String] the delimiter value for connecting array elements.
  # @param last_delimiter [String] the connecting word for the last array element.
  def to_sentence(delimiter: ", ", last_delimiter: "and")
    return "" if none?
    return self.first if one?

    "#{self[0...-1].join(delimiter)} #{last_delimiter} #{self[-1]}"
  end
end
