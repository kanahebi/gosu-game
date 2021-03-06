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
    @gameover_image   = Gosu::Image.new("image/gameover.png", :tileable => true)
    @gameclear_image  = Gosu::Image.new("image/gameclear.png", :tileable => true)
    @clear_beep = Gosu::Sample.new("sound/clear.wav")
    @font = Gosu::Font.new(20)
    @gameover = false
    @gameclear = false

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
    unless @gameover || @gameclear
      if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
        @player.move_left
      end
  	   if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
        @player.move_right
      end
      @stars.each{|star| star.drop}
      @bombs.each{|bomb| bomb.drop}
      @player.collect_stars(@stars)
      if @player.hit_bombs?(@bombs)
        @gameover = true
      end
      if @player.score > 100
        @gameclear = true
        @clear_beep.play
      end
    else
      sleep 2
      close
    end
  end

  def draw
    unless @gameover || @gameclear
      @player.draw
      @stars.each{|star| star.draw}
      @bombs.each{|bomb| bomb.draw}
      @background_image.draw(0, 0, 0)
      @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    else
      if @gameover
        sleep 1
        @gameover_image.draw(0,0,0)
        @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
      else
        @gameclear_image.draw(0,0,0)
        @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
      end
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
