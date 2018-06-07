class Player
  def initialize
    @image = Gosu::Image.new("image/kanahebi.png")
    @beep = Gosu::Sample.new("sound/ring.wav")
    @x = @y = @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def move_left
    if @x > 40
      @x -= 4.5
    end
  end

  def move_right
    if @x < 600
      @x += 4.5
    end
  end

  def ring
    @beep.play
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
