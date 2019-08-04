class Food < Gosu::Window
  attr_reader :x, :y

  def initialize
    pos_initialize
  end

  def pos_initialize
    @x = (1...620).to_a.sample
    @y = (1...460).to_a.sample
  end

  def draw
    draw_rect(x, y, 20, 20, Gosu::Color.new(0xff_ff0000))
  end
end
