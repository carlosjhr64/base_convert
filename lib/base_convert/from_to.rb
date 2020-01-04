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

  def inspect
    d0 = DIGITS_KEYS.detect{|_|DIGITS[_].start_with? @digits}
    d0 = @digits[0] + @digits[@base-1] if d0.nil?
    d1 = DIGITS_KEYS.detect{|_|DIGITS[_].start_with? @to_digits}
    d1 = @to_digits[0] + @to_digits[@to_base-1] if d1.nil?
    "#{@base}:#{d0},#{@to_base}:#{d1}"
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
