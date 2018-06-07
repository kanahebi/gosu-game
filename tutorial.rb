require "gosu"
require "./player"
require "./star"

class Tutorial < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Tutorial Game"

    @background_image = Gosu::Image.new("image/background.png", :tileable => true)

    @player = Player.new
    @player.warp(320, 390)
    @stars = []
    @stars << Star.new
    @stars << Star.new
    @stars << Star.new
    @stars << Star.new
    @stars << Star.new
    @stars.each.with_index(1){|star, i| star.warp(rand(640), rand(100)-100*i)}
  end

  def update
    if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      @player.move_left
    end
    if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      @player.move_right
    end
    if Gosu.button_down? Gosu::KB_SPACE
      @player.ring
    end
    @stars.each{|star| star.drop}
  end

  def draw
    @player.draw
    @stars.each{|star| star.draw}
    @background_image.draw(0, 0, 0)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

Tutorial.new.show