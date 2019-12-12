# http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
module BaseConvert
module Helpers
  include Configuration
  include BaseConvert

  def _infer_digits_from_string
    if @string.chars.all?{|_|WORD.include?_}
      WORD
    elsif @string.chars.all?{|_|QGRAPH.include?_}
      QGRAPH
    else
      raise "Need digits."
    end
  end

  def _digits!
    if @digits.nil?
      @digits = @integer.nil? ? _infer_digits_from_string : WORD
      if @base and @base > @digits.length
        if @base > QGRAPH.length
          raise "Need digits that can cover base #{base}."
        else
          @digits = QGRAPH
        end
      end
    elsif @digits.is_a? Symbol
      digits = DIGITS[@digits]
      raise "Unrecognized digits #{@digits}." if digits.nil?
      @digits = digits
    end
    raise "digits must be a String." unless @digits.is_a? String
  end

  def _base!
    if @base.nil?
      _digits!
      if @integer.nil?
        @base = @digits.length
      else
        @base = 10
      end
    elsif @base.is_a? Symbol
      base = BASE[@base]
      raise "Unrecognized base #{@base}." if base.nil?
      @base = base
    end
    raise "base must be a Integer greater than 1." unless @base.is_a? Integer and @base > 1
  end

  def _validate
    raise "digits must cover base" if @base > @digits.length
    raise "digits must not have duplicates" if @digits.length > @digits.chars.uniq.length
    unless @string.nil?
      "digits must cover string" unless @string.chars.all?{|_|@digits.include?_}
    end
    unless @integer.nil?
      "integer can't be negative" if @integer < 0
    end
  end

  def _integer!
    _base!
    _digits!
    _validate if @validate
    @string.upcase! if @base <= INDEXa and @digits == WORD
    @integer = toi
  end

  def _string!
    _base!
    _digits!
    _validate if @validate
    @string = tob
  end
end
end
