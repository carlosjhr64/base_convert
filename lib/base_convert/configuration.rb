module BaseConvert
  QUOTES      = %("'`).freeze
  UNDERSCORE  = '_'.freeze
  AMBIGUOUS   = 'B8G6I1l0OQDS5Z2'.freeze

  GRAPH       = 0.upto(255).map{|i| i.chr}.select{|c| c=~/[[:graph:]]/}.join.freeze
  QGRAPH      = GRAPH.delete(QUOTES).freeze
  WORD_       = QGRAPH.chars.select{|c| c=~/\w/}.join.freeze
  WORD        = WORD_.delete(UNDERSCORE).freeze
  UNAMBIGUOUS = WORD.delete(AMBIGUOUS).freeze
  G94         = (WORD + QGRAPH.delete(WORD_) + QUOTES + UNDERSCORE).freeze

  BASE64      = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'.freeze

  INDEXa = G94.index('a')

  BASE = lambda do |base|
    case base
    when Integer
      raise "base must be greater than 1" unless base > 1
      base
    when :g94,:graph,:g       then 94
    when :qgraph,:q           then 91
    when :word_,:_            then 63
    when :word,:w             then 62
    when :unambiguous,:u      then 47
    when :base64,:b64         then 64
    when :hexadecimal,:hex,:h then 16
    when :decimal,:dec,:d     then 10
    when :octal,:oct,:o       then 8
    when :binary,:bin,:b      then 2
    when Symbol
      raise "unrecognized base key"
    else
      raise "base must be Integer|Symbol"
    end
  end

  DIGITS = lambda do |digits|
    case digits
    when nil             then G94
    when :base64,:b64    then BASE64
    when :graph,:g       then GRAPH
    when :qgraph,:q      then QGRAPH
    when :unambiguous,:u then UNAMBIGUOUS
    when :word_,:_       then WORD_
    when :g94,
         :word,:w,
         :hexadecimal,:hex,:h,
         :hexadecimal,:hex,:h,
         :decimal,:dec,:d,
         :octal,:oct,:o,
         :binary,:bin,:b then G94
    when String
      if d = [G94,WORD_,BASE64,QGRAPH,GRAPH,UNAMBIGUOUS].detect{|_|_.start_with? digits}
        digits = d
      else
        raise "need at least 2 digits" unless digits.length > 1
        raise "digits must not have duplicates." if digits.length > digits.chars.uniq.length
      end
      digits
    when Integer
      raise "need digits" if digits > 94
      G94
    when Symbol
      raise "unrecognized digits key"
    else
      raise "digits must be String|Symbol|Integer"
    end
  end

  DIGITS_KEY = lambda do |digits|
    case digits
    when G94         then :g94
    when WORD_       then :_
    when BASE64      then :b64
    when QGRAPH      then :q
    when GRAPH       then :g
    when UNAMBIGUOUS then :u
    else
      (digits[0]+digits[1]+digits[-1]).to_sym
    end
  end

  BASE_KEYS = [
    :g94,
    :graph,:g,
    :qgraph,:q,
    :word_,:_,
    :word,:w,
    :unambiguous,:u,
    :base64,:b64,
    :hexadecimal,:hex,:h,
    :decimal,:dec,:d,
    :octal,:oct,:o,
    :binary,:bin,:b,
  ]
end
