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

  BASE = {
    g94:         94,
    graph:       94,  g:   94,
    qgraph:      91,  q:   91,
    base64:      64,  b64: 64,
    word_:       63,  _:   63,
    word:        62,  w:   62,
    unambiguous: 47,  u:   47,
    hexadecimal: 16,  hex: 16,  h: 16,
    decimal:     10,  dec: 10,  d: 10,
    octal:        8,  oct:  8,  o:  8,
    binary:       2,  bin:  2,  b:  2,
  }

  def BASE.[](base)
    case base
    when Symbol
      super or raise 'unrecognized base key'
    when Integer
      raise 'base must be greater than 1' unless base > 1
      base
    else
      raise 'base must be Integer|Symbol'
    end
  end

  DIGITS = {
    g94:         G94,
    word:        G94,         w:   G94,
    hexadecimal: G94,         hex: G94,  h: G94,
    decimal:     G94,         dec: G94,  d: G94,
    octal:       G94,         oct: G94,  o: G94,
    binary:      G94,         bin: G94,  b: G94,
    graph:       GRAPH,       g:   GRAPH,
    qgraph:      QGRAPH,      q:   QGRAPH,
    base64:      BASE64,      b64: BASE64,
    word_:       WORD_,       _:   WORD_,
    unambiguous: UNAMBIGUOUS, u:   UNAMBIGUOUS,
  }

  def DIGITS.[](digits)
    case digits
    when nil then G94
    when Symbol
      super or raise 'unrecognized digits key'
    when String
      if d = [G94,WORD_,BASE64,QGRAPH,GRAPH,UNAMBIGUOUS].detect{|_|_.start_with? digits}
        digits = d
      else
        raise 'need at least 2 digits' unless digits.length > 1
        raise 'digits must not have duplicates' if digits.length > digits.chars.uniq.length
      end
      digits
    when Integer
      raise 'need digits to cover base' if digits > 94
      G94
    else
      raise 'digits must be String|Symbol|Integer'
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
end
