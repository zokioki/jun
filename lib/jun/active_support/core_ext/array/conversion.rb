# frozen_string_literal: true

class Array
  def to_sentence(delimiter: ", ", last_delimiter: "and")
    return "" if none?
    return self.first if one?

    "#{self[0...-1].join(delimiter)} #{last_delimiter} #{self[-1]}"
  end
end
