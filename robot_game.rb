# frozen_string_literal: true
class RobotGame
  def initialize
    @placement = Placement.unplaced
  end

  def place(x, y, direction = 'NORTH')
    new_placement = Placement.place(x, y, direction)
    @placement = new_placement if new_placement.valid?
  end

  def move
    @placement = Move.move(@placement)
  end

  def left
    @placement = Placement.place(@placement.x, @placement.y, Direction.left(@placement))
  end

  def right
    @placement = Placement.place(@placement.x, @placement.y, Direction.right(@placement))
  end

  def report
    @placement.report
  end
end

class Move
  class << self
    def move(placement)
      new_placement =
        case placement.direction
        when 'EAST'
          east_move(placement)
        when 'WEST'
          west_move(placement)
        when 'NORTH'
          north_move(placement)
        when 'SOUTH'
          south_move(placement)
        end
      new_placement.valid? ? new_placement : placement
    end

    private
    def east_move(placement)
      new_x = placement.x + 1
      Placement.place(new_x, placement.y, placement.direction)
    end

    def west_move(placement)
      new_x = placement.x - 1
      Placement.place(new_x, placement.y, placement.direction)
    end

    def north_move(placement)
      new_y = placement.y + 1
      Placement.place(placement.x, new_y, placement.direction)
    end

    def south_move(placement)
      new_y = placement.y - 1
      Placement.place(placement.x, new_y, placement.direction)
    end
  end
end

class Direction
  ORDERED_VALID_DIRECTIONS = [
    'NORTH'.freeze,
    'EAST'.freeze,
    'SOUTH'.freeze,
    'WEST'.freeze,
  ].freeze

  class << self
    def left(placement)
      new_index = ORDERED_VALID_DIRECTIONS.index(placement.direction) - 1
      ORDERED_VALID_DIRECTIONS[new_index]
    end

    def right(placement)
      current_index = ORDERED_VALID_DIRECTIONS.index(placement.direction)
      ORDERED_VALID_DIRECTIONS.rotate[current_index]
    end

    def valid?(direction)
      ORDERED_VALID_DIRECTIONS.include?(direction)
    end
  end
end

class Placement
  VALID_X = 0..4
  VALID_Y = 0..4

  attr_accessor :x, :y, :direction

  def valid?
    true
  end

  def report
    [@x, @y, @direction]
  end

  private
  def initialize(x, y, direction)
    @x = x
    @y = y
    @direction = direction
  end

  class << self
    def place(x, y, direction)
      return NullPlacement.new unless Direction.valid?(direction)
      return NullPlacement.new unless on_board?(x, y)
      Placement.new(x, y, direction)
    end

    def unplaced
      NullPlacement.new
    end

    private
    def on_board?(x, y)
      VALID_X.include?(x) && VALID_Y.include?(y)
    end
  end

  class NullPlacement
    def report
      nil
    end

    def valid?
      false
    end
  end
end
