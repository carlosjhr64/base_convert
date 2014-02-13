module BASE_CONVERT
class BaseConvert
  include CONFIG
  extend FUNCTIONS
  extend HELPERS

  attr_accessor :from_digits, :to_digits
  def initialize(basefrom, baseto=basefrom)
    @basefrom    = BaseConvert.base(basefrom)
    @baseto      = BaseConvert.base(baseto)
    @from_digits = BaseConvert.digits(basefrom)
    @to_digits   = BaseConvert.digits(baseto)

    BaseConvert.validate(@baseto, @to_digits)
    BaseConvert.validate(@basefrom, @from_digits)
  end
 
  def base2integer(string)
    string = string.upcase if BaseConvert.upcase?(@basefrom, @from_digits) # covenience
    BaseConvert.validate_string(string, @basefrom, @from_digits)
    BaseConvert.to_integer(string, @basefrom, @from_digits)
  end
  alias base2dec base2integer 
 
  def integer2base(integer)
    BaseConvert.to_base(integer, @baseto, @to_digits)
  end
  alias dec2base integer2base

  def convert(string)
    integer2base base2integer string.to_s
  end

end
end
