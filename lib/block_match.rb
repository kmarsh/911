class BlockMatch < Struct.new(:block, :street)
  def to_s
    "Block: #{block} #{street}"
  end
end