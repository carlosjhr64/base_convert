module BaseConvert
module Configuration

  GRAPH  = 0.upto(255).map{|i| i.chr}.select{|c| c=~/[[:graph:]]/}.join.freeze
  QGRAPH = GRAPH.delete(%('"`)).freeze

  WORD_  = 0.upto(255).map{|i| i.chr}.select{|c| c=~/\w/}.join.freeze
  WORD   = WORD_.delete('_').freeze
  INDEXa = WORD.index('a').freeze

  AMBIGUOUS   = 'B8G6I1l0OQDS5Z2'.freeze
  UNAMBIGUOUS = WORD.delete(AMBIGUOUS).freeze

  BASE = {
    :graph       => GRAPH.length,
    :qgraph      => QGRAPH.length,
    :word_       => WORD_.length,
    :word        => WORD.length,
    :unambiguous => UNAMBIGUOUS.length,
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
  BASE[:w_] = BASE[:word_]
  BASE[:w]  = BASE[:word]
  BASE[:u]  = BASE[:unambiguous]

  DIGITS = {
    :graph       => GRAPH,
    :g           => GRAPH,
    :qgraph      => QGRAPH,
    :q           => QGRAPH,
    :word_       => WORD_,
    :w_          => WORD_,
    :word        => WORD,
    :w           => WORD,
    :unambiguous => UNAMBIGUOUS,
    :u           => UNAMBIGUOUS,
  }

end
end
