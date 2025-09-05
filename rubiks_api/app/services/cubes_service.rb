class CubesService
  def self.create_cube
    cube = Cube.new
    cube.state = {
        "front" => Array.new(3) { Array.new(3, 'R') },
        "back" => Array.new(3) { Array.new(3, 'O') },
        "left" => Array.new(3) { Array.new(3, 'G') },
        "right" => Array.new(3) { Array.new(3, 'B') },
        "top" => Array.new(3) { Array.new(3, 'W') },
        "bottom" => Array.new(3) { Array.new(3, 'Y') }
    }
    cube.save!
    cube
  end

  def self.rotate_cube(id, face, direction)
  cube = Cube.find(id)
  raise "Invalid face" unless %w[top bottom left right front back middle-x middle-y middle-z].include?(face)
  raise "Invalid direction" unless %w[right left up down].include?(direction)

  raise "Invalid direction" unless 
  (["top", "bottom", "middle-y", "front", "back", "middle-z"].include?(face) && %w[left right].include?(direction)) ||
  (["left", "right", "middle-x"].include?(face) && %w[up down].include?(direction))

  case face
    when "top"
      rotate_row_based(cube, "top", direction, 0)
    when "bottom"
      rotate_row_based(cube, "bottom", direction, 2)
    when "middle-y"
      rotate_row_based(cube, "middle-y", direction, 1)
    when "left"
      self.rotate_column_based(cube, "left", direction, 0)
    when "right"
      self.rotate_column_based(cube, "right", direction, 2)
    when "middle-x"
      self.rotate_column_based(cube, "middle-x", direction, 1)
    when "front"
      self.rotate_front(cube, direction)
    when "back"
      rotate_back(cube, direction)
    when "middle-z"
      rotate_middle_z(cube, direction)
  end

  cube.save!
  cube
end



def self.rotate_front(cube, direction)
  cube.state["front"] = rotate_matrix(cube.state["front"], direction)
    top    = cube.state["top"]
    bottom = cube.state["bottom"]
    left   = cube.state["left"]
    right  = cube.state["right"]

    if direction == "left"
      temp0 = top[2][0]
      temp1 = top[2][1]
      temp2 = top[2][2]

      top[2][0] = right[0][0]
      top[2][1] = right[1][0]
      top[2][2] = right[2][0]

      right[0][0] = bottom[0][2]
      right[1][0] = bottom[0][1]
      right[2][0] = bottom[0][0]

      bottom[0][0] = left[0][2]
      bottom[0][1] = left[1][2]
      bottom[0][2] = left[2][2]

      left[0][2] = temp2
      left[1][2] = temp1
      left[2][2] = temp0

    elsif direction == "right"
      temp0 = top[2][0]
      temp1 = top[2][1]
      temp2 = top[2][2]

      top[2][0] = left[2][2]
      top[2][1] = left[1][2]
      top[2][2] = left[0][2]

      left[0][2] = bottom[0][0]
      left[1][2] = bottom[0][1]
      left[2][2] = bottom[0][2]

      bottom[0][0] = right[2][0]
      bottom[0][1] = right[1][0]
      bottom[0][2] = right[0][0]

      right[0][0] = temp0
      right[1][0] = temp1
      right[2][0] = temp2
    end
end

def self.rotate_back(cube, direction)
  cube.state["back"] = rotate_matrix(cube.state["back"], direction)

  reversed_direction = direction == "left" ? "right" : "left"
    
    top    = cube.state["top"]
    bottom = cube.state["bottom"]
    left   = cube.state["left"]
    right  = cube.state["right"]
    
    if direction == "left"
      temp0 = top[0][0]
      temp1 = top[0][1]
      temp2 = top[0][2]

      top[0][0] = right[0][2]
      top[0][1] = right[1][2]
      top[0][2] = right[2][2]

      right[0][2] = bottom[2][2]
      right[1][2] = bottom[2][1]
      right[2][2] = bottom[2][0]

      bottom[2][0] = left[0][0]
      bottom[2][1] = left[1][0]
      bottom[2][2] = left[2][0]

      left[0][0] = temp2
      left[1][0] = temp1
      left[2][0] = temp0

    elsif direction == "right"
      temp0 = top[0][0]
      temp1 = top[0][1]
      temp2 = top[0][2]

      top[0][0] = left[2][0]
      top[0][1] = left[1][0]
      top[0][2] = left[0][0]

      left[0][0] = bottom[2][0]
      left[1][0] = bottom[2][1]
      left[2][0] = bottom[2][2]

      bottom[2][0] = right[2][2]
      bottom[2][1] = right[1][2]
      bottom[2][2] = right[0][2]

      right[0][2] = temp0
      right[1][2] = temp1
      right[2][2] = temp2
    end

end

def self.rotate_middle_z(cube, direction)
  
  top = cube.state["top"]
  bottom = cube.state["bottom"]
  left = cube.state["left"]
  right = cube.state["right"]

  if direction == "left"
    temp0 = top[1][0]
    temp1 = top[1][1]
    temp2 = top[1][2]

    top[1][0] = right[0][1]
    top[1][1] = right[1][1]
    top[1][2] = right[2][1]

    right[0][1] = bottom[1][2]
    right[1][1] = bottom[1][1]
    right[2][1] = bottom[1][0]

    bottom[1][0] = left[0][1]
    bottom[1][1] = left[1][1]
    bottom[1][2] = left[2][1]

    left[0][1] = temp2
    left[1][1] = temp1
    left[2][1] = temp0

  elsif direction == "right"
    temp0 = top[1][0]
    temp1 = top[1][1]
    temp2 = top[1][2]

    top[1][0] = left[2][1]
    top[1][1] = left[1][1]
    top[1][2] = left[0][1]

    left[0][1] = bottom[1][0]
    left[1][1] = bottom[1][1]
    left[2][1] = bottom[1][2]

    bottom[1][0] = right[2][1]
    bottom[1][1] = right[1][1]
    bottom[1][2] = right[0][1]

    right[0][1] = temp0
    right[1][1] = temp1
    right[2][1] = temp2
  end
end

  #left right middle-x
  def self.rotate_column_based(cube, face, direction, column_index)
    cube.state[face] = rotate_matrix(cube.state[face], direction) unless face.include?("middle")

    reverse_index = if column_index == 2
      0
    elsif column_index == 0  
      2
    else
      1
    end

    front, back, top, bottom = cube.state.values_at("front", "back", "top", "bottom")

    columns = [get_column(front, column_index), get_column(top, column_index), get_column(back, reverse_index).reverse, get_column(bottom, column_index)]

    direction == "down" ? columns.rotate!(1) : columns.rotate!(-1)

    set_column(front, column_index, columns[0])
    set_column(top, column_index, columns[1])
    set_column(back, reverse_index, columns[2].reverse)
    set_column(bottom, column_index, columns[3])
  end

  #top, bottom
  def self.rotate_row_based(cube, face, direction, row_index)
    cube.state[face] = rotate_matrix(cube.state[face], direction) unless face.include?("middle")
    
    front, back, left, right = cube.state.values_at("front", "back", "left", "right")
    
    rows = [get_row(front, row_index), get_row(left, row_index), get_row(back, row_index), get_row(right, row_index)]
    
    direction == "left" ? rows.rotate!(-1) : rows.rotate!(1) #rotira sve redove u krug

    set_row(front, row_index, rows[0])
    set_row(left, row_index, rows[1])
    set_row(back, row_index, rows[2])
    set_row(right, row_index, rows[3])
  end

  
  def self.get_row(side, row_index)
    side[row_index]
  end

  def self.get_column(side, col_index)
    side.map { |row| row[col_index] }
  end

  def self.set_row(side, row_index, values)
    side[row_index] = values
  end

  def self.set_column(side, col_index, values)
    side.each_with_index { |row, i| row[col_index] = values[i] }
  end

  def self.rotate_matrix(matrix, direction)
    case direction
    when "left", "down"
    [
      [matrix[2][0], matrix[1][0], matrix[0][0]],
      [matrix[2][1], matrix[1][1], matrix[0][1]],
      [matrix[2][2], matrix[1][2], matrix[0][2]]
    ].map(&:reverse)
    when "right", "up"
    [
      [matrix[0][2], matrix[1][2], matrix[2][2]],
      [matrix[0][1], matrix[1][1], matrix[2][1]],
      [matrix[0][0], matrix[1][0], matrix[2][0]]
    ].map(&:reverse)
    else
      raise "rotate_matrix only accepts 'right', 'left', 'up' and 'down'"
    end
  end

end
