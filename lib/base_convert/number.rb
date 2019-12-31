module BaseConvert
class Number
  include BaseConvert

  def self.infer(string)
    return 2, G94 if string.empty?
    max = string.chars.map{|_|G94.index(_)}.max
    return 2,  G94  if max < 2
    return 4,  G94  if max < 4
    return 8,  G94  if max < 8
    return 10, G94  if max < 10
    return 16, G94  if max < 16
    return 32, G94  if max < 32
    [UNAMBIGUOUS, BASE64, WORD].each do |digits|
      return digits.length, digits  if string.chars.all?{|_|digits.include?_}
    end
    return 64, G94  if max < 64
    return G94.length, G94  if max < 64
  end

  attr_reader :base, :digits
  def initialize(counter, base: nil, digits: nil, validate: true)
    # validate
    case validate
    when true, false
      @validate = validate
    else
      raise "validate must be either true of false."
    end

    # counter
    case counter
    when String
      @string = counter
      base, digits = Number.infer(counter)  if base.nil? and digits.nil?
    when Integer
      @integer = counter
      base, digits = 10, G94  if base.nil? and digits.nil?
    else
      raise "Need counter String|Integer."
    end

    # digits
    if digits.is_a? Symbol
      digits = DIGITS[digits]
      raise "Unrecognized digits #{@digits}." if digits.nil?
    end
    digits = DIGITS[@base] if digits.nil?
    digits = G94 if digits.nil?
    raise "digits must be a String." unless digits.is_a? String
    @digits = digits

    # base
    if base.is_a? Symbol
      base = BASE[base]
      raise "Unrecognized base #{@base}." if base.nil?
    end
    base = @digits.length if base.nil?
    raise "base must be an Integer." unless base.is_a? Integer
    @base = base

    # validate
    if @validate
      raise "digits must cover base." if @base > @digits.length
      raise "digits must not have duplicates." if @digits.length > @digits.chars.uniq.length
      unless @string.nil? or @string.empty?
        @string.upcase! if @base <= INDEXa and @digits.equal? G94
        raise "digits must cover string." unless @string.chars.all?{|_|@digits.include?_}
        raise "digits in string must be under base." unless @base > @string.chars.map{|_|@digits.index(_)}.max
      end
      unless @integer.nil?
        raise "integer can't be negative." if @integer < 0
      end
    end

    @integer = toi if @integer.nil?
    @string  = tob if @string.nil?
  end

  def validate?
    @validate
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
