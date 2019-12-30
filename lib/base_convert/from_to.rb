module BaseConvert
class FromTo
  include BaseConvert

  def initialize(base: 10, to_base: base, digits: G94, to_digits: digits)
    base      = BASE[base]         if base.is_a?      Symbol
    to_base   = BASE[to_base]      if to_base.is_a?   Symbol
    digits    = DIGITS[digits]     if digits.is_a?    Symbol
    to_digits = DIGITS[to_digits]  if to_digits.is_a? Symbol
    raise "base must cover digits." if base > digits.length or to_base > to_digits.length
    @base, @to_base, @digits, @to_digits = base, to_base, digits, to_digits
  end
 
  def convert(counter)
    case counter
    when Integer
      tob(counter, @to_base, @to_digits)
    when String
      tob(toi(counter), @to_base, @to_digits)
    else
      raise "counter must be String|Integer."
    end
  end
  alias :[] :convert
end
end
