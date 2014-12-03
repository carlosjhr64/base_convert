module BaseConvert
class FromTo
  include Configuration
  extend Functions
  extend Helpers

  attr_accessor :from_digits, :to_digits
  def initialize(basefrom, baseto=basefrom)
    @basefrom    = FromTo.base(basefrom)
    @baseto      = FromTo.base(baseto)
    @from_digits = FromTo.digits(basefrom)
    @to_digits   = FromTo.digits(baseto)

    FromTo.validate(@baseto, @to_digits)
    FromTo.validate(@basefrom, @from_digits)
  end
 
  def base2integer(string)
    string = string.upcase if FromTo.upcase?(@basefrom, @from_digits) # covenience
    FromTo.validate_string(string, @basefrom, @from_digits)
    FromTo.to_integer(string, @basefrom, @from_digits)
  end
  alias base2dec base2integer 
 
  def integer2base(integer)
    FromTo.to_base(integer, @baseto, @to_digits)
  end
  alias dec2base integer2base

  def convert(string)
    integer2base base2integer string.to_s
  end

end
end
