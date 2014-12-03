# http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
module BASE_CONVERT
module HELPERS
  include CONFIG

  def upcase?(base, digits)
    base <= INDEXa and digits.equal?(WORD)
  end

  def validate(base, digits)
    raise 'base is not an integer'               unless base.kind_of?(Integer)
    raise 'digits not an String'                 unless digits.kind_of?(String)
    raise 'base not between 2 and digits.length' unless base.between?(2, digits.length)
  end

  def validate_string(string, base, digits)
    string.chars.uniq.each do |c|
      raise 'String has invalid character' unless (i=digits.index(c)) and (i<base)
    end
  end

  def digits(base)
    if base.class == Symbol
      if digits = DIGITS[base]
        return digits
      end
      base = BASE[base]
    end
    (base > WORD.length)? QGRAPH : WORD
  end

  def base(base)
    (base.class == Symbol)? BASE[base]: base
  end

end
end
