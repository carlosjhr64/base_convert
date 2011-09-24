# http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
class BaseConvert
  DIGITS = 0.upto(255).map{|i| i.chr}.select{|c| c=~/\w/ && c=~/[^_]/} # 0..9 a..z A..Z
  QGRAPH = 0.upto(255).map{|i| i.chr}.select{|c| c=~/[[:graph:]]/ && c=~/[^`'"]/}

  BASE = {
	:word		=> DIGITS.length,
	:qgraph		=> QGRAPH.length,
	:hexadecimal	=> 16,
	:hex		=> 16,
	:decimal	=> 10,
	:dec		=> 10,
	:octal		=> 8,
	:oct		=> 8,
	:binary		=> 2,
  }

  attr_accessor :from_digits, :to_digits
  def initialize(basefrom,baseto=nil)
    baseto = basefrom if baseto.nil?
    @basefrom		= BASE[basefrom]	|| basefrom
    @baseto		= BASE[baseto]		|| baseto
    dl = DIGITS.length
    @from_digits	= ((basefrom == :qgraph) || (@basefrom > dl))? QGRAPH : DIGITS
    @to_digits		= ((baseto   == :qgraph) || (@baseto > dl))? QGRAPH : DIGITS
  end

  def convert(str)
    if str.class == String
      dec = base2dec(str)
      return (@baseto == @basefrom)? dec : dec2base(dec)
    end
    dec2base(str)
  end
 
  def base2dec(str)
    str = str.upcase if @basefrom < 37
    raise ArgumentError, "base is invalid" unless @basefrom.between?(2, @from_digits.length)
    res = 0
    str.to_s.each_char do |c|
      idx = @from_digits[0,@basefrom].find_index(c)
      idx.nil? and raise ArgumentError, "invalid base-#{@basefrom} digit: #{c}"
      res = res * @basefrom + idx
    end
    res
  end
 
  def dec2base(n)
    return "0" if n == 0
    raise ArgumentError, "base is invalid" unless @baseto.between?(2, @to_digits.length)
    res = []
    while n > 0
      n, r = n.divmod(@baseto)
      res.unshift(@to_digits[r])
    end
    res.join("") 
  end
end
