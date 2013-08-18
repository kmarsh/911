class AddressMatch < Struct.new(:number, :street)
  def to_s
    "Address: #{number} #{street}"
  end

  def geocode

  end
end