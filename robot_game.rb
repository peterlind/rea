class RobotGame
  VALID_X = 0..4
  VALID_Y = 0..4
  VALID_DIRECTIONS = [
    'NORTH'.freeze,
    'SOUTH'.freeze,
    'EAST'.freeze,
    'WEST'.freeze,
  ].freeze

  def initialize
  end

  def place(x, y, facing = 'NORTH')
    ensure_on_board(x, y)
    ensure_valid_direction(facing)
    @current_x = x
    @current_y = y
    @current_facing = facing
  end

  def report
    [@current_x, @current_y, @current_facing]
  end

  private
  def ensure_valid_direction(direction)
    raise "Invalid direction (#{direction})" unless VALID_DIRECTIONS.include?(direction)
  end

  def ensure_on_board(x, y)
    raise "Invalid x (#{x})" unless VALID_X.include?(x)
    raise "Invalid y (#{x})" unless VALID_Y.include?(y)
  end
end
