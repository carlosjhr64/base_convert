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
    :g94         => G94.length,          # 94
    :graph       => GRAPH.length,        # 94
    :qgraph      => QGRAPH.length,       # 91
    :word_       => WORD_.length,        # 63
    :word        => WORD.length,         # 62
    :unambiguous => UNAMBIGUOUS.length,  # 47
    :base64      => 64,
    :b64         => 64,
    :hexadecimal => 16,
    :hex         => 16,
    :h           => 16,
    :decimal     => 10,
    :dec         => 10,
    :d           => 10,
    :octal       => 8,
    :oct         => 8,
    :o           => 8,
    :binary      => 2,
    :bin         => 2,
    :b           => 2,
  }

  BASE[:g]  = BASE[:graph]
  BASE[:q]  = BASE[:qgraph]
  BASE[:_] = BASE[:word_]
  BASE[:w]  = BASE[:word]
  BASE[:u]  = BASE[:unambiguous]

  DIGITS = {
    :g94         => G94,
    :graph       => GRAPH,
    :g           => GRAPH,
    :qgraph      => QGRAPH,
    :q           => QGRAPH,
    :word_       => WORD_,
    :_           => WORD_,
    :word        => WORD,
    :w           => WORD,
    :unambiguous => UNAMBIGUOUS,
    :u           => UNAMBIGUOUS,
    :base64      => BASE64,
    :b64         => BASE64,
  }

  # For inspect method
  DIGITS_KEYS = [:g94, :_, :b64, :q, :g, :u]
end
