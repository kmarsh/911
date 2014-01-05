BlockMatch = Struct.new(:block, :street) do
  def to_s
    "Block: #{block} #{street}"
  end

  def geocode
  end
end
