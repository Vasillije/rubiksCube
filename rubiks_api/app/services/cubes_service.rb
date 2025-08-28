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
    cube.state["top"] = rotate_matrix(cube.state["top"], direction)
    front = cube.state["front"]
    back  = cube.state["back"]
    left  = cube.state["left"]
    right = cube.state["right"]

    if direction == "right"
      temp = front[0].dup
      front[0] = left[0].dup
      left[0]  = back[0].dup
      back[0]  = right[0].dup
      right[0] = temp
    elsif direction == "left"
      temp = front[0].dup
      front[0] = right[0].dup
      right[0] = back[0].dup
      back[0]  = left[0].dup
      left[0]  = temp
    end

  when "bottom"
    cube.state["bottom"] = rotate_matrix(cube.state["bottom"], direction)
    front = cube.state["front"]
    back  = cube.state["back"]
    left  = cube.state["left"]
    right = cube.state["right"]

    if direction == "right"
      temp = front[2].dup
      front[2] = left[2].dup
      left[2]  = back[2].dup
      back[2]  = right[2].dup
      right[2] = temp
    elsif direction == "left"
      temp = front[2].dup
      front[2] = right[2].dup
      right[2] = back[2].dup
      back[2]  = left[2].dup
      left[2]  = temp
    end

  when "middle-y"
    front = cube.state["front"]
    back  = cube.state["back"]
    left  = cube.state["left"]
    right = cube.state["right"]

    if direction == "right"
      temp = front[1].dup
      front[1] = left[1].dup
      left[1]  = back[1].dup
      back[1]  = right[1].dup
      right[1] = temp
    elsif direction == "left"
      temp = front[1].dup
      front[1] = right[1].dup
      right[1] = back[1].dup
      back[1]  = left[1].dup
      left[1]  = temp
    end

  when "left"
    cube.state["left"] = rotate_matrix(cube.state["left"], direction)
    front = cube.state["front"]
    back  = cube.state["back"]
    top   = cube.state["top"]
    bottom = cube.state["bottom"]

    if direction == "up"
      temp0 = front[0][0].dup
      temp1 = front[1][0].dup
      temp2 = front[2][0].dup
      front[0][0] = bottom[0][0].dup
      front[1][0] = bottom[1][0].dup
      front[2][0] = bottom[2][0].dup

      bottom[0][0] = back[2][2].dup
      bottom[1][0] = back[1][2].dup
      bottom[2][0] = back[0][2].dup

      back[0][2] = top[2][0].dup
      back[1][2] = top[1][0].dup
      back[2][2] = top[0][0].dup

      top[0][0] = temp0
      top[1][0] = temp1
      top[2][0] = temp2
    elsif direction == "down"
      temp0 = front[0][0].dup
      temp1 = front[1][0].dup
      temp2 = front[2][0].dup

      front[0][0] = top[0][0].dup
      front[1][0] = top[1][0].dup
      front[2][0] = top[2][0].dup

      top[0][0] = back[2][2].dup
      top[1][0] = back[1][2].dup
      top[2][0] = back[0][2].dup

      back[0][2] = bottom[2][0].dup
      back[1][2] = bottom[1][0].dup
      back[2][2] = bottom[0][0].dup

      bottom[0][0] = temp0
      bottom[1][0] = temp1
      bottom[2][0] = temp2
    end
  when "right"
    cube.state["right"] = rotate_matrix(cube.state["right"], direction)
    front = cube.state["front"]
    back  = cube.state["back"]
    top   = cube.state["top"]
    bottom = cube.state["bottom"]

    if direction == "up"
      temp0 = front[0][2].dup
      temp1 = front[1][2].dup
      temp2 = front[2][2].dup
      front[0][2] = bottom[0][2].dup
      front[1][2] = bottom[1][2].dup
      front[2][2] = bottom[2][2].dup

      bottom[0][2] = back[2][0].dup
      bottom[1][2] = back[1][0].dup
      bottom[2][2] = back[0][0].dup

      back[0][0] = top[2][2].dup
      back[1][0] = top[1][2].dup
      back[2][0] = top[0][2].dup

      top[0][2] = temp0
      top[1][2] = temp1
      top[2][2] = temp2
    elsif direction == "down"
      temp0 = front[0][2].dup
      temp1 = front[1][2].dup
      temp2 = front[2][2].dup
      front[0][2] = top[0][2].dup
      front[1][2] = top[1][2].dup
      front[2][2] = top[2][2].dup

      top[0][2] = back[2][0].dup
      top[1][2] = back[1][0].dup
      top[2][2] = back[0][0].dup

      back[0][0] = bottom[2][2].dup
      back[1][0] = bottom[1][2].dup
      back[2][0] = bottom[0][2].dup

      bottom[0][2] = temp0
      bottom[1][2] = temp1
      bottom[2][2] = temp2
    end

  when "middle-x"
    front = cube.state["front"]
    back  = cube.state["back"]
    top   = cube.state["top"]
    bottom = cube.state["bottom"]

    if direction == "up"
      temp0 = front[0][1].dup
      temp1 = front[1][1].dup
      temp2 = front[2][1].dup
      front[0][1] = bottom[0][1].dup
      front[1][1] = bottom[1][1].dup
      front[2][1] = bottom[2][1].dup

      bottom[0][1] = back[0][1].dup
      bottom[1][1] = back[1][1].dup
      bottom[2][1] = back[2][1].dup

      back[0][1] = top[0][1].dup
      back[1][1] = top[1][1].dup
      back[2][1] = top[2][1].dup

      top[0][1] = temp0
      top[1][1] = temp1
      top[2][1] = temp2
    elsif direction == "down"
      temp0 = front[0][1].dup
      temp1 = front[1][1].dup
      temp2 = front[2][1].dup
      front[0][1] = top[0][1].dup
      front[1][1] = top[1][1].dup
      front[2][1] = top[2][1].dup

      top[0][1] = back[0][1].dup
      top[1][1] = back[1][1].dup
      top[2][1] = back[2][1].dup

      back[0][1] = bottom[0][1].dup
      back[1][1] = bottom[1][1].dup
      back[2][1] = bottom[2][1].dup

      bottom[0][1] = temp0
      bottom[1][1] = temp1
      bottom[2][1] = temp2
    end

  when "front"
    cube.state["front"] = rotate_matrix(cube.state["front"], direction)
    top = cube.state["top"]
    bottom  = cube.state["bottom"]
    left   = cube.state["left"]
    right = cube.state["right"]

    if direction == "left"
      temp0 = top[2][0].dup
      temp1 = top[2][1].dup
      temp2 = top[2][2].dup

      top[2][0] = right[0][0].dup
      top[2][1] = right[1][0].dup
      top[2][2] = right[2][0].dup

      right[0][0] = bottom[0][2].dup
      right[1][0] = bottom[0][1].dup
      right[2][0] = bottom[0][0].dup

      bottom[0][0] = left[0][2].dup
      bottom[0][1] = left[1][2].dup
      bottom[0][2] = left[2][2].dup

      left[0][2] = temp2
      left[1][2] = temp1
      left[2][2] = temp0
    elsif direction == "right"
      temp0 = top[2][0].dup
      temp1 = top[2][1].dup
      temp2 = top[2][2].dup

      top[2][0] = left[2][2].dup
      top[2][1] = left[1][2].dup
      top[2][2] = left[0][2].dup

      left[0][2] = bottom[0][0].dup
      left[1][2] = bottom[0][1].dup
      left[2][2] = bottom[0][2].dup
      
      bottom[0][0] = right[2][0].dup
      bottom[0][1] = right[1][0].dup
      bottom[0][2] = right[0][0].dup
      
      right[0][0] = temp0
      right[1][0] = temp1
      right[2][0] = temp2
    end

  when "back"
    cube.state["back"] = rotate_matrix(cube.state["back"], direction)
    
    top = cube.state["top"]
    bottom = cube.state["bottom"]
    left = cube.state["left"]
    right = cube.state["right"]
    
    if direction == "left"
      temp0 = top[0][0].dup
      temp1 = top[0][1].dup
      temp2 = top[0][2].dup

      top[0][0] = right[0][2].dup
      top[0][1] = right[1][2].dup
      top[0][2] = right[2][2].dup

      right[0][2] = bottom[2][2].dup
      right[1][2] = bottom[2][1].dup
      right[2][2] = bottom[2][0].dup

      bottom[2][0] = left[0][0].dup
      bottom[2][1] = left[1][0].dup
      bottom[2][2] = left[2][0].dup

      left[0][0] = temp2
      left[1][0] = temp1
      left[2][0] = temp0

    elsif direction == "right"
      temp0 = top[0][0].dup
      temp1 = top[0][1].dup
      temp2 = top[0][2].dup

      top[0][0] = left[2][0].dup
      top[0][1] = left[1][0].dup
      top[0][2] = left[0][0].dup

      left[0][0] = bottom[2][0].dup
      left[1][0] = bottom[2][1].dup
      left[2][0] = bottom[2][2].dup

      bottom[2][0] = right[2][2].dup
      bottom[2][1] = right[1][2].dup
      bottom[2][2] = right[0][2].dup

      right[0][2] = temp0
      right[1][2] = temp1
      right[2][2] = temp2
      
    end
  
    when "middle-z"
      top = cube.state["top"]
      bottom = cube.state["bottom"]
      left = cube.state["left"]
      right = cube.state["right"]
      if direction == "left"
        temp0 = top[1][0].dup
        temp1 = top[1][1].dup
        temp2 = top[1][2].dup

        top[1][0] = right[0][1].dup
        top[1][1] = right[1][1].dup
        top[1][2] = right[2][1].dup

        right[0][1] = bottom[1][2].dup
        right[1][1] = bottom[1][1].dup
        right[2][1] = bottom[1][0].dup

        bottom[1][0] = left[0][1].dup
        bottom[1][1] = left[1][1].dup
        bottom[1][2] = left[2][1].dup

        left[0][1] = temp2
        left[1][1] = temp1
        left[2][1] = temp0

      elsif direction == "right"
        temp0 = top[1][0].dup
        temp1 = top[1][1].dup
        temp2 = top[1][2].dup

        top[1][0] = left[2][1].dup
        top[1][1] = left[1][1].dup
        top[1][2] = left[0][1].dup

        left[0][1] = bottom[1][0].dup
        left[1][1] = bottom[1][1].dup
        left[2][1] = bottom[1][2].dup

        bottom[1][0] = right[2][1].dup
        bottom[1][1] = right[1][1].dup
        bottom[1][2] = right[0][1].dup

        right[0][1] = temp0
        right[1][1] = temp1
        right[2][1] = temp2
      end
  end

  cube.save!
  cube
end



  def self.rotate_matrix(matrix, direction)
    case direction
    when "right", "down"
    [
      [matrix[2][0], matrix[1][0], matrix[0][0]],
      [matrix[2][1], matrix[1][1], matrix[0][1]],
      [matrix[2][2], matrix[1][2], matrix[0][2]]
    ].map(&:reverse)
    when "left", "up"
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
