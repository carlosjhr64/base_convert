module BaseConvert
class FromTo
  include Configuration
  include BaseConvert

  def initialize(base: 10, to_base: 16, digits: WORD, to_digits: digits)
    base      = BASE[base]         if base.is_a?      Symbol
    to_base   = BASE[to_base]      if to_base.is_a?   Symbol
    digits    = DIGITS[digits]     if digits.is_a?    Symbol
    to_digits = DIGITS[to_digits]  if to_digits.is_a? Symbol
    raise "base must cover digits" if base > digits.length or to_base > to_digits.length
    @base, @to_base, @digits, @to_digits = base, to_base, digits, to_digits
  end
 
  def convert(string)
    tob(toi(string.to_s), @to_base, @to_digits)
  end
  alias :[] :convert
end
end
