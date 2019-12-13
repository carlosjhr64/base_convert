module BaseConvert
class FromTo
  include Configuration
  include BaseConvert

  def initialize(base: 10, to_base: 16, digits: WORD, to_digits: digits)
    @base, @to_base, @digits, @to_digits = base, to_base, digits, to_digits
  end
 
  def convert(string)
    tob(toi(string.to_s), @to_base, @to_digits)
  end
  alias :[] :convert
end
end
