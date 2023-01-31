class Float
  def round_to_half
    if self.to_s.split('.').last.size > 2
      if (self * 10).modulo(1) >= 0.25 && (self * 10).modulo(1) < 0.5
        return (((self * 10) + (0.5 - (self * 10).modulo(1))) / 10).round(2)
      elsif (self * 10).modulo(1) >= 0.5 && (self * 10).modulo(1) <= 1
        return (((self * 10) + (1 - (self * 10).modulo(1)) / 10) / 10).round(2)
      end
    end

    self.round(2)
  end

  def with_two_decimals
    '%.2f' % self
  end
end