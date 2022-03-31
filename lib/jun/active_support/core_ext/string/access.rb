# frozen_string_literal: true

class String
  def at(position)
    self[position]
  end

  def from(position)
    self[position, length]
  end

  def to(position)
    position += size if position.negative?
    position = -1 if position.negative?

    self[0, position + 1]
  end
end
