# http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
module BaseConvert
  VERSION = '3.0.191214'

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

  autoload :Configuration, 'base_convert/configuration'
  autoload :FromTo,        'base_convert/from_to'
  autoload :Number,        'base_convert/number'
end
#`ruby`
