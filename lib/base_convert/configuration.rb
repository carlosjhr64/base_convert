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
    :decimal     => 10,
    :dec         => 10,
    :octal       => 8,
    :oct         => 8,
    :binary      => 2,
  }

  DIGITS = {
    :word   => WORD,
    :qgraph => QGRAPH,
  }

end
end
