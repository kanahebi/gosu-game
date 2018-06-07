class Player
  attr_reader :x, :y, :score

  def initialize
    @image = Gosu::Image.new("image/kanahebi.png")
    @star_beep = Gosu::Sample.new("sound/ring.wav")
    @bomb_beep = Gosu::Sample.new("sound/bomb.wav")
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

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def collect_stars(stars)
    stars.each do |star|
      if Gosu.distance(@x, @y, star.x, star.y) < 50
        @score += 10
        @star_beep.play
        star.reset
      end
    end
  end

  def hit_bombs?(bombs)
    hit = false
    bombs.each do |bomb|
      if Gosu.distance(@x, @y, bomb.x, bomb.y) < 50
        @bomb_beep.play
        hit = true
      end
    end
    return hit
  end
end
