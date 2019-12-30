# http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
module BaseConvert
  def toi(string=@string, base=@base, digits=@digits)
    integer = 0
    string.each_char do |c|
      index = digits.index(c)
      integer = integer * base + index
    end
    integer
  end

  def tob(integer=@integer, base=@base, digits=@digits)
    return digits[0] if integer == 0
    string = ''
    while integer > 0
      integer, index = integer.divmod(base)
      string = string.insert(0, digits[index])
    end
    string
  end

  extend self
end
