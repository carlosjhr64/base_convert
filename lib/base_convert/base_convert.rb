module BASE_CONVERT
class BaseConvert
  include CONFIG
  extend FUNCTIONS

  attr_accessor :from_digits, :to_digits
  def initialize(basefrom, baseto=basefrom)
    @basefrom    = BaseConvert.base(basefrom)
    @baseto      = BaseConvert.base(baseto)
    @from_digits = BaseConvert.digits(basefrom)
    @to_digits   = BaseConvert.digits(baseto)

    BaseConvert.validate(@baseto, @to_digits)
    BaseConvert.validate(@basefrom, @from_digits)
  end
 
  def base2dec(string)
    string = string.upcase if BaseConvert.upcase?(@basefrom, @from_digits) # covenience
    BaseConivert.validate_string(string, @basefrom, @from_digits)
    BaseConvert.to_integer(string, @basefrom, @from_digits)
  end
 
  def dec2base(integer)
    BaseConvert.to_base(integer, @baseto, @to_digits)
  end

  def convert(string)
    dec2base base2dec string
  end

end
end
