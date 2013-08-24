class Range
  # Return relative position of num in Range, between [0, 1]
  # Returns min or max for outliers (num is < min or num is > max)
  def interpolate(num)
    return 0.0 if num.to_f < self.min.to_f
    return 1.0 if num.to_f > self.max.to_f

    (num.to_f - self.min.to_f) / (self.max.to_f - self.min.to_f)
  end
end