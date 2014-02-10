module BASE_CONVERT
class Number < String
  include CONFIG
  extend FUNCTIONS

  def initialize(counter, base=10, digits=Number.digits(base), validate=true)
    super(counter.to_s)
    @base   = Number.base(base)
    @digits = digits
    if validate
      self.upcase! if Number.upcase?(@base, @digits)
      Number.validate(@base, @digits)
      Number.validate_string(self, @base, @digits)
    end
  end

  def to_integer
    Number.to_integer(self, @base, @digits)
  end

  def to_base(base, digits=Number.digits(base), validate=true)
    base   = Number.base(base)
    Number.validate(base, digits) if validate
    integer = self.to_integer
    string = Number.to_base(integer, base, digits)
    Number.new(string, base, digits, false) # no need to validate
  end

end
end
