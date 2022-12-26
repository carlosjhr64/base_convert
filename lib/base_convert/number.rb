module BaseConvert
class Number
  include Methods
  DIGITS.memoize!
  INDEXa = DIGITS[:P95].index('a')

  def self.infer(string, error:'digits not all in P95')
    p95 = DIGITS[:P95]
    return 2, p95  if string.empty?
    chars = string.chars
    raise error unless chars.all?{|_|p95.include?_}
    max = chars.map{|_|p95.index(_)}.max
    return 95, p95  if max == 94 # string has a space digit.
    return 2,  p95  if max < 2
    return 4,  p95  if max < 4
    return 8,  p95  if max < 8
    return 10, p95  if max < 10
    return 16, p95  if max < 16
    return 32, p95  if max < 32
    u47 = DIGITS[:U47]
    return 47, u47  if chars.all?{|_|u47.include?_}
    return 64, p95  if max < 64
    b64 = DIGITS[:B64]
    return 64, b64  if chars.all?{|_|b64.include?_}
    return 94, p95
  end

  attr_reader :base, :digits
  def initialize(counter=0, base: nil, digits: nil, validate: true)
    # validate
    case validate
    when true, false
      @validate = validate
    else
      raise 'validate must be either true or false'
    end

    # counter
    string = nil
    case counter
    when String
      string = counter
      if base.nil? and digits.nil?
        base, digits = Number.infer(counter, error:'need digits to cover string')
      end
    when Integer
      @integer = counter
      base, digits = 10, DIGITS[:P95]  if base.nil? and digits.nil?
    else
      raise 'need counter String|Integer'
    end

    # digits
    @digits = DIGITS[digits || base]

    # base
    base = digits if base.nil? and digits.is_a? Symbol
    @base = BASE[base || @digits.length]

    # validate
    if @validate
      raise 'digits must cover base'  if @base > @digits.length
      unless string.nil? or string.empty?
        indeces = string.chars.map{|_|@digits.index(_)}
        if missing = indeces.any?{|_|_.nil?} or exceeding = indeces.any?{|_|_>=@base}
          if @base <= INDEXa and DIGITS[:P95].start_with?(@digits)
            string = string.upcase
            indeces = string.chars.map{|_|@digits.index(_)}
            missing = indeces.any?{|_|_.nil?} or exceeding = indeces.any?{|_|_>=@base}
          end
          raise 'digits must cover string' if missing
          raise 'digits in string must be under base'  if exceeding
        end
      end
      unless @integer.nil?
        raise 'integer can not be negative'  if @integer < 0
      end
    end

    @integer = toi(string)  if @integer.nil?
  end

  def inspect
    d = DIGITS.label(@digits)
    "#{to_s} #{@base}:#{d}"
  end

  def validate?
    @validate
  end

  alias to_s tos

  def to_i
    @integer
  end

  def to_base(base, digits=(base.is_a?Symbol)? DIGITS[base] : @digits, validate=@validate)
    Number.new @integer, base: base, digits: digits, validate: validate
  end

  def to_digits(digits, base=@base, validate=@validate)
    Number.new @integer, base: base, digits: digits, validate: validate
  end
end
end
