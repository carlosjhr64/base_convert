module BaseConvert
class Number
  include Configuration
  include BaseConvert

  def _infer_digits_from_string
    if @string.chars.all?{|_|WORD_.include?_}
      @string.include?('_')? WORD_ : WORD
    elsif @string.chars.all?{|_|GRAPH.include?_}
      @string.match?(/['"`]/)? GRAPH : QGRAPH
    else
      raise "Need digits."
    end
  end

  def _infer_base_from_string
    min = 1 + @digits.index(@string.chars.max)
    max = @digits.length
    return max if max==min
    case @digits
    when WORD, WORD_
      if min <= 32
        raise "Need base for WORD or WORD_." if @string.length < 8
        return  8 if min <= 8
        return 16 if min <= 16
        return 32
      end
    when UNAMBIGUOUS
      if min <= 22
        raise "Need base for UNAMBIGUOUS." if @string.length < 8
        return 22
      end
    when QGRAPH, GRAPH
      n = @digits.index 'a'
      if min <= n
        raise "Need base for QGRAPH or GRAPH." if @string.length < 8
        return n
      end
    end
    return max
  end

  def _digits!
    if @digits.nil?
      @digits = @integer.nil? ? _infer_digits_from_string : WORD
      if @base and @base > @digits.length
        if @base == 64
          @digits = BASE64
        elsif @base <= QGRAPH.length
          @digits = QGRAPH
        elsif @base <= GRAPH.length
          @digits = GRAPH
        else
          raise "Need digits that can cover base #{@base}."
        end
      end
    else
      if @digits.is_a? Symbol
        digits = DIGITS[@digits]
        raise "Unrecognized digits #{@digits}." if digits.nil?
        @digits = digits
      else
        raise "digits must be a String of at least length 2." unless @digits.is_a?(String) and @digits.length > 2
      end
    end
  end

  def _base!
    if @base.nil?
      _digits!
      if @integer.nil?
        @base = _infer_base_from_string
      else
        @base = @digits.length
      end
    else
      if @base.is_a? Symbol
        base = BASE[@base]
        raise "Unrecognized base #{@base}." if base.nil?
        @base = base
      else
        raise "base must be an Integer greater than 1." unless @base.is_a?(Integer) and @base > 1
      end
      _digits!
    end
  end

  def _validate
    raise "digits must cover base." if @base > @digits.length
    raise "digits must not have duplicates." if @digits.length > @digits.chars.uniq.length
    unless @string.nil?
      raise "digits must cover string." unless @string.chars.all?{|_|@digits.include?_}
    end
    unless @integer.nil?
      raise "integer can't be negative." if @integer < 0
    end
  end

  def _integer!
    _base!
    _validate if @validate
    @string.upcase! if @base <= INDEXa and @digits == WORD
    @integer = toi
  end

  def _string!
    _base!
    _validate if @validate
    @string = tob
  end

  def initialize(counter, base: nil, digits: nil, validate: true)
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
      raise "Need counter String|Integer."
    end
  end

  def to_s
    @string
  end

  def to_i
    @integer
  end

  def to_base(base, digits=@digits, validate=@validate)
    Number.new @integer, base: base, digits: digits, validate: validate
  end

  def to_digits(digits, base=@base, validate=@validate)
    Number.new @integer, base: base, digits: digits, validate: validate
  end
end
end
