require "gosu"
require "./player"
require "./star"
require "./bomb"

module ZOrder
    BACKGROUND, STARS, PLAYER, UI = *0..3
end

class Tutorial < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Tutorial Game"

    @background_image = Gosu::Image.new("image/background.png", :tileable => true)
    @gameover_image = Gosu::Image.new("image/gameover.png", :tileable => true)
    @font = Gosu::Font.new(20)
    @gameover = false

    @player = Player.new
    @player.warp(320, 390)
    @stars = []
    @stars << Star.new
    @stars << Star.new
    @stars << Star.new
    @stars << Star.new
    @stars << Star.new
    @stars.each.with_index(1){|star, i| star.warp(rand(640), rand(100)-100*i)}
    @bombs = []
    @bombs << Bomb.new
    @bombs << Bomb.new
    @bombs.each.with_index(1){|bomb, i| bomb.warp(rand(640), rand(100)-100*i)}
  end

  def update
    if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      @player.move_left
    end
    if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      @player.move_right
    end
    @stars.each{|star| star.drop}
    @bombs.each{|bomb| bomb.drop}
    @player.collect_stars(@stars)
    if @gameover
      sleep 2
      close
    end
    if @player.hit_bombs?(@bombs)
      @gameover = true
    end
  end

  def draw
    unless @gameover
      @player.draw
      @stars.each{|star| star.draw}
      @bombs.each{|bomb| bomb.draw}
      @background_image.draw(0, 0, 0)
      @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    else
      sleep 1
      @gameover_image.draw(0,0,0)
      @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    end
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
