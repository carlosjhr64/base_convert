module BASE_CONVERT
module CONFIG

  QGRAPH = 0.upto(255).map{|i| i.chr}.select{|c| c=~/[[:graph:]]/ && c=~/[^`'"]/}

  WORD   = 0.upto(255).map{|i| i.chr}.select{|c| c=~/\w/ && c=~/[^_]/} # 0..9 a..z A..Z
  INDEXa = WORD.find_index('a')

  BASE = {
    :word        => WORD.length,
    :qgraph      => QGRAPH.length,
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
