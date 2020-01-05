module BaseConvert
class Number
  include BaseConvert

  def self.infer(string)
    return 2, G94 if string.empty?
    chars = string.chars
    raise 'Need digits.' unless chars.all?{|_|G94.include?_}
    max = chars.map{|_|G94.index(_)}.max
    return 2,  G94  if max < 2
    return 4,  G94  if max < 4
    return 8,  G94  if max < 8
    return 10, G94  if max < 10
    return 16, G94  if max < 16
    return 32, G94  if max < 32
    [UNAMBIGUOUS, BASE64].each do |digits|
      return digits.length, digits  if chars.all?{|_|digits.include?_}
    end
    return 64, G94  if max < 64
    return G94.length, G94  if max < 64
  end

  attr_reader :base, :digits
  def initialize(counter=0, base: nil, digits: nil, validate: true)
    # validate
    case validate
    when true, false
      @validate = validate
    else
      raise "validate must be either true of false."
    end

    # counter
    string = nil
    case counter
    when String
      string = counter
      base, digits = Number.infer(counter)  if base.nil? and digits.nil?
    when Integer
      @integer = counter
      base, digits = 10, G94  if base.nil? and digits.nil?
    else
      raise "Need counter String|Integer."
    end

    # digits
    @digits = DIGITS[digits || base]

    # base
    base = digits if base.nil? and digits.is_a? Symbol
    @base = BASE[base || @digits.length]

    # validate
    if @validate
      raise "digits must cover base." if @base > @digits.length
      unless string.nil? or string.empty?
        indeces = string.chars.map{|_|@digits.index(_)}
        if missing = indeces.any?{|_|_.nil?} or exceeding = indeces.any?{|_|_>=@base}
          if @base <= INDEXa and G94.start_with?(@digits)
            string = string.upcase
            indeces = string.chars.map{|_|@digits.index(_)}
            missing = indeces.any?{|_|_.nil?} or exceeding = indeces.any?{|_|_>=@base}
          end
          raise "digits must cover string." if missing
          raise "digits in string must be under base." if exceeding
        end
      end
      unless @integer.nil?
        raise "integer can't be negative." if @integer < 0
      end
    end

    @integer = toi(string) if @integer.nil?
  end

  def inspect
    d = DIGITS_KEY[@digits]
    "#{to_s} #{@base}:#{d}"
  end

  def validate?
    @validate
  end

  alias to_s tob

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
