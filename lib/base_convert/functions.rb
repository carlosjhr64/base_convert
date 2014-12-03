# http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
module BaseConvert
module Functions

  def to_integer(string, base, digits)
    integer = 0
    string.each_char do |c|
      index = digits.index(c)
      integer = integer * base + index
    end
    integer
  end

  def to_base(integer, base, digits)
    return digits[0] if integer == 0
    string = ''
    while integer > 0
      integer, index = integer.divmod(base)
      string = string.insert(0, digits[index])
    end
    string
  end

end
end
