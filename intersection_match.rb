class IntersectionMatch < Struct.new(:street_1, :street_2)
  def initialize(street_1, street_2)
    @street_1 = street_1.strip
    @street_2 = street_2.strip
  end

  def to_s
    "Intersection: #{street_1} & #{street_2 }"
  end
end