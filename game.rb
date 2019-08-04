require 'gosu'
require_relative 'snake.rb'
require_relative 'food.rb'

class Game < Gosu::Window
  def initialize
    super 640, 480, false, 60
    self.caption = "Snake"
    @snake = Snake.new
    @food = Food.new
    @font = Gosu::Font.new(20)
  end

  def draw
    @snake.draw
    @food.draw
    @font.draw_text("Score: #{@snake.score}", 10, 10, 0)
  end

  def update
    if button_down? Gosu::Button::KbLeft
      @snake.direction = "Left" unless @snake.direction == "Right"
    elsif button_down? Gosu::Button::KbRight
      @snake.direction = "Right" unless @snake.direction == "Left"
    elsif button_down? Gosu::Button::KbDown
      @snake.direction = "Down" unless @snake.direction == "Up"
    elsif button_down? Gosu::Button::KbUp
      @snake.direction = "Up" unless @snake.direction == "Down"
    end
    close if @snake.game_over == true
    close if button_down? Gosu::Button::KbEscape

    @snake.move
    @snake.eat(@food)
  end
end
