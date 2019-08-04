class Snake < Gosu::Window
  attr_reader :game_over, :score, :direction, :snake
  attr_writer :direction
  def initialize
    @snake = [[20, 20]]
    @direction = "Right"
    @game_over = false
    @grow = false
    @score = 0
    @speed = 8
    @beep = Gosu::Sample.new("media/beep.wav")
  end

  def draw
    @snake.each do |x, y|
      x_size = 12 + @speed
      y_size = 12 + @speed
      draw_rect(x, y, x_size, y_size, Gosu::Color.new(0xff_00ffff))
    end
  end

  def move
    x = @snake[0][0].to_i
    y = @snake[0][1].to_i
    new_position = []

    case @direction
    when "Left" then
      new_position << x - @speed
      new_position << y
    when "Right" then
      new_position << x + @speed
      new_position << y
    when "Down" then
      new_position << x
      new_position << y + @speed
    when "Up" then
      new_position << x
      new_position << y - @speed
    end
    if @snake.include? new_position
      @game_over = true
    elsif @snake.any? { |square| square[0] >= 620 } || @snake.any? { |square| square[1] >= 460 }
      @game_over = true
    elsif @snake.any? { |square| square[0] <= 0 } || @snake.any? { |square| square[1] <= 0 }
      @game_over = true
    else
      @snake.insert(0, new_position)
      @snake.pop unless @grow == true
    end
    @grow = false
  end

  def eat(food)
    @snake.each do |x, y|
      if ((food.x..(food.x + 20)).to_a & ((x..(x + (12 + @speed))).to_a)).any? && ((food.y..(food.y + 20)).to_a & ((y..(y + (12 + @speed))).to_a)).any?
        @score += 1
        food.pos_initialize
        @grow = true
        @speed += 1
        @beep.play
      end
    end
  end
end
