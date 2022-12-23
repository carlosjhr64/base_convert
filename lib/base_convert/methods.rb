# http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
module BaseConvert
module Methods
  def toi(string=to_s, base=@base, digits=@digits)
    return nil if string.empty?
    string.chars.inject(0){_1*base + digits.index(_2)}
  end

  def tos(integer=to_i, base=@base, digits=@digits)
    return '' if integer.nil?
    return digits[0] if integer == 0
    string = ''
    while integer > 0
      integer, index = integer.divmod(base)
      string = string.prepend digits[index]
    end
    string
  end

  def chars_ordered?(digits=@digits)
    digits.chars.each_cons(2).all?{_1<_2}
  end

  extend self
end
end
