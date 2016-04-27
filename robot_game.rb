class RobotGame
  VALID_X = 0..4
  VALID_Y = 0..4
  ORDERED_VALID_DIRECTIONS = [
    'NORTH'.freeze,
    'EAST'.freeze,
    'SOUTH'.freeze,
    'WEST'.freeze,
  ].freeze

  def initialize
    @has_placement = false
  end

  def place(x, y, facing = 'NORTH')
    x, y = [x, y].map(&:to_i)
    return unless on_board?(x, y)
    return unless valid_direction?(facing)
    @current_x = x
    @current_y = y
    @current_facing = facing
    @has_placement = true
  end

  def move
    return unless @has_placement

    case @current_facing
    when 'EAST'
      new_x = @current_x + 1
      @current_x = new_x if on_board?(new_x, @current_y)
    when 'WEST'
      new_x = @current_x - 1
      @current_x = new_x if on_board?(new_x, @current_y)
    when 'NORTH'
      new_y = @current_y + 1
      @current_y = new_y if on_board?(@current_x, new_y)
    when 'SOUTH'
      new_y = @current_y - 1
      @current_y = new_y if on_board?(@current_x, new_y)
    end
  end

  def left
    return unless @has_placement

    new_index = ORDERED_VALID_DIRECTIONS.index(@current_facing) - 1
    new_direction = ORDERED_VALID_DIRECTIONS[new_index]

    @current_facing = new_direction
  end

  def right
    return unless @has_placement

    current_index = ORDERED_VALID_DIRECTIONS.index(@current_facing)
    new_direction = ORDERED_VALID_DIRECTIONS.rotate[current_index]

    @current_facing = new_direction
  end

  def report
    return unless @has_placement

    [@current_x, @current_y, @current_facing]
  end

  private
  def valid_direction?(direction)
    ORDERED_VALID_DIRECTIONS.include?(direction)
  end

  def on_board?(x, y)
    VALID_X.include?(x) && VALID_Y.include?(y)
  end
end
