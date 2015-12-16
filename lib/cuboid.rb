
class Cuboid
  attr_accessor :origin, :width, :height, :length
  X=0
  Y=1
  Z=2

  def initialize(x,y,z,w,h,l)
    if w <=0 || h<=0 || l <=0
      raise raise ArgumentError.new("length, height and width must be larger than 0")
    end

    @origin = [x,y,z]
    @width = w
    @height = h
    @length = l
  end

  def move_to!(x, y, z)
    @origin = [x,y,z]
  end

  def move!(axis, distance)
    case axis
      when :x
        move_to!(origin[X]+distance, origin[Y], origin[Z])
      when :y
        move_to!(origin[X], origin[Y]+distance, origin[Z])
      when :z
        move_to!(origin[X], origin[Y], origin[Z]+distance)
    end
  end

  def max_vert
    [origin[X]+width, origin[Y]+height, origin[Z]+length]
  end

  # returns true if the two cuboids intersect each other.  False otherwise.
  def intersects?(other)
    return false if self.equal?(other)
    !(above?(other) || below?(other) || right_of?(other) || left_of?(other) || behind?(other) || in_front_of?(other))
  end

  # rotate 90 degress around center (note this isn't the origin)
  def rotate!(axis)
    center = [origin[X]+width/2, origin[Y]+height/2, origin[Z]+length/2]
    case axis
    when :x
      self.height, self.length = self.length, self.height
    when :y
      self.width, self.length = self.length, self.width
    when :z
      self.width, self.height = self.height, self.width
    end
    self.origin = [center[X]-width/2, center[Y]-height/2, center[Z]-length/2]
  end

  def above?(other)
    origin[Y] > other.max_vert[Y]
  end

  def below?(other)
    max_vert[Y] < other.origin[Y]
  end

  def right_of?(other)
    origin[X] > other.max_vert[X]
  end

  def left_of?(other)
    max_vert[X] < other.origin[X]
  end

  def behind?(other)
    origin[Z] > other.max_vert[Z]
  end

  def in_front_of?(other)
    max_vert[Z] < other.origin[Z]
  end

  def vertices
    [ origin,
     [origin[X],       origin[Y],        origin[Z]+length],
     [origin[X],       origin[Y]+height, origin[Z]],
     [origin[X],       origin[Y]+height, origin[Z]+length],
     [origin[X]+width, origin[Y],        origin[Z]],
     [origin[X]+width, origin[Y],        origin[Z]+length],
     [origin[X]+width, origin[Y]+height, origin[Z]],
     max_vert]
  end

  def to_s
    "(#{origin[X]}, #{origin[Y]}, #{origin[Z]}), (#{max_vert[X]}, #{max_vert[Y]}, #{max_vert[Z]})"
  end

end
