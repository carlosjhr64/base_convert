module BaseConvert
class FromTo
  include BaseConvert

  def initialize(base: 10, to_base: base, digits: G94, to_digits: digits)
    base      = BASE[base]
    to_base   = BASE[to_base]
    digits    = DIGITS[digits]
    to_digits = DIGITS[to_digits]
    raise 'base must cover digits' if base > digits.length or to_base > to_digits.length
    @base, @to_base, @digits, @to_digits = base, to_base, digits, to_digits
  end

  def inspect
    d0 = DIGITS_KEY[@digits]
    d1 = DIGITS_KEY[@to_digits]
    "#{@base}:#{d0},#{@to_base}:#{d1}"
  end
 
  def convert(counter)
    case counter
    when Integer
      tob(counter, @to_base, @to_digits)
    when String
      tob(toi(counter), @to_base, @to_digits)
    else
      raise 'counter must be String|Integer'
    end
  end
  alias :[] :convert
end
end
