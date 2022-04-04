# frozen_string_literal: true

class Array
  # Returns the second element in the array.
  def second
    self[1]
  end

  # Returns the third element in the array.
  def third
    self[2]
  end

  # Returns the fourth element in the array.
  def fourth
    self[3]
  end

  # Returns the fifth element in the array.
  def fifth
    self[4]
  end

  # Returns the third-to-last element in the array.
  def third_to_last
    self[-3]
  end

  # Returns the second-to-last element in the array.
  def second_to_last
    self[-2]
  end
end
