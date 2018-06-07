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

  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu.distance(@x, @y, star.x, star.y) < 35
        @score += 10
        @beep.play
        star.reset
        true
      else
        false
      end
    end
  end
end
