# http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
module BaseConvert
  def toi(string=to_s, base=@base, digits=@digits)
    return nil if string.empty?
    integer = 0
    string.each_char do |c|
      index = digits.index(c)
      integer = integer * base + index
    end
    integer
  end

  def tob(integer=to_i, base=@base, digits=@digits)
    return '' if integer.nil?
    return digits[0] if integer == 0
    string = ''
    while integer > 0
      integer, index = integer.divmod(base)
      string = string.insert(0, digits[index])
    end
    string
  end

  def ascii_ordered?(digits=@digits)
    (1..(digits.length-1)).all?{|i|digits[i-1]<digits[i]}
  end

  extend self
end
