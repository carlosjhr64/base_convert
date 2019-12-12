module BaseConvert
class Number
  include Configuration
  include Helpers

  def initialize(counter, base: nil, digits: nil, validate: $DEBUG)
    @base, @digits, @validate = base, digits, validate
    @string, @integer = nil, nil
    case counter
    when String
      @string = counter
      _integer!
    when Integer
      @integer = counter
      _string!
    else
      raise "Need counter String|Integer"
    end
  end

  def to_s
    @string
  end
  alias :to_str :to_s

  def to_i
    @integer
  end
  alias :to_int :to_i

  def to_base(base, digits=@digits, validate=@validate)
    Number.new @integer, base: base, digits: digits, validate: validate
  end

  def to_digits(digits, base=@base, validate=@validate)
    Number.new @integer, base: base, digits: digits, validate: validate
  end
end
end
