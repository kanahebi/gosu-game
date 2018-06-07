class Bomb
  attr_reader :x, :y

  def initialize
    @image = Gosu::Image.new("image/star_black.png")
    @x = @y = @angle = 0.0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def drop
    @y += 4.5
    if @y > 480
      reset
    end
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def reset
    warp(rand(640), rand(100)-100)
  end
end
