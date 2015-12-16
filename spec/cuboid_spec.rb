require 'cuboid'

describe Cuboid do

  let (:subject) { Cuboid.new(1,1,1,10,10,10) }
  let (:other) { Cuboid.new(1,1,1,10,10,10) }
  let (:rotator) { Cuboid.new(-2,-4,-8,4,8,16) }

  describe "#initialize" do
    it "raises ArgumentError if width, height, length invalid" do
      expect{Cuboid.new(1,1,1,-1,0,0)}.to raise_error(ArgumentError)
    end
  end

  describe "move!_to" do
    it "changes the origin in the simple happy case" do
      expect(subject.move_to!(1,2,3)).to eq [1,2,3]
    end
  end

  describe "max_vert" do
    it "returns the vertex furthest from the origin" do
      expect(subject.max_vert).to eq [11,11,11]
    end
  end

  describe "vertices" do
    it "returns 8 vertices" do
      expect(subject.vertices.size).to be 8
    end
    it "returns the correct vertices" do
      o = Cuboid.new(0,0,0,1,2,3)
      expect(o.vertices[0]).to eq [0,0,0]
      expect(o.vertices[1]).to eq [0,0,3]
      expect(o.vertices[2]).to eq [0,2,0]
      expect(o.vertices[3]).to eq [0,2,3]
      expect(o.vertices[4]).to eq [1,0,0]
      expect(o.vertices[5]).to eq [1,0,3]
      expect(o.vertices[6]).to eq [1,2,0]
      expect(o.vertices[7]).to eq [1,2,3]
    end
  end

  describe "intersects?" do
    it "returns false when compared to itself" do
      expect(subject.intersects?(subject)).to be false
    end

    it "returns true when other is exact same size and position" do
      expect(subject.intersects?(other)).to be true
    end

    it "returns true when other is inside" do
      expect(subject.intersects?(Cuboid.new(2,2,2,1,1,1))).to be true
    end

    it "returns false when below" do
      subject.move!(:y, -11)
      expect(subject.intersects?(other)).to be false
    end

    it "returns false when above" do
      subject.move!(:y, 11)
      expect(subject.intersects?(other)).to be false
    end

    it "returns false when left of" do
      subject.move!(:x, -11)
      expect(subject.intersects?(other)).to be false
    end

    it "returns false when right of" do
      subject.move!(:x, 11)
      expect(subject.intersects?(other)).to be false
    end

    it "returns false when in front of" do
      subject.move!(:z, -11)
      expect(subject.intersects?(other)).to be false
    end

    it "returns false when behind" do
      subject.move!(:z, 11)
      expect(subject.intersects?(other)).to be false
    end

    it "returns true when corners overlap" do
      subject.move!(:x, 11)
      expect(subject.intersects?(other)).to be false
      subject.move!(:x, -1)
      expect(subject.intersects?(other)).to be true
    end
  end

  describe "#rotate" do
    it "should rotate 90 degrees around x" do
      rotator.rotate!(:x)
      expect(rotator.origin).to eq [-2,-8,-4]
    end

    it "should rotate 90 degrees around x" do
      rotator.rotate!(:y)
      expect(rotator.origin).to eq [-8,-4,-2]
    end
    it "should rotate 90 degrees around x" do
      rotator.rotate!(:z)
      expect(rotator.origin).to eq [-4,-2,-8]
    end
  end
end
