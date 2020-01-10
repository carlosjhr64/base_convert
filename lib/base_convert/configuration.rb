module BaseConvert
  DIGITS = Digits.new

  # Naming these letter sequences is inpired by
  # (but not the same as)
  # Unicode character’s General Category.
  DIGITS[:bangs]      = '!?'.freeze               # Used as method name suffix
  DIGITS[:typers]     = '$&@'.freeze              # Used as variable name prefix
  DIGITS[:operators]  = '*+-/<=>^~'.freeze        # Used as mathematical operators
  DIGITS[:separators] = ',.:;|'.freeze            # Used to separated items
  DIGITS[:scapes]     = '#\\'.freeze              # Used to escape what's next
  DIGITS[:groupers]   = '()[]{}'.freeze           # Used to group items
  DIGITS[:quotes]     = %("'`).freeze             # Quotes
  DIGITS[:quoters]    = %(\%"'`).freeze           # Used to quote strings('%' not ASCII ordered)
  DIGITS[:spacers]    = '_ '.freeze               # 1_000 == 1000 #=> true (Not ASCII ordered)
  DIGITS[:ambiguous]  = '012568BDGIOQSZl'.freeze  # ASCII ordered ambiguous characters

  ### Recursive string constructors ###
  # 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!?$&@*+-/<=>^~,.:;|#\\()[]{}%"'`_ 
  DIGITS[:P95] = :alnum_bangs_typers_operators_separators_scapes_groupers_quoters_spacers
  INDEXa = DIGITS[:P95].index('a')
  # 0123456789ABCDEF
  DIGITS[:hexadecimal] = DIGITS[:hex] = DIGITS[:h] = :P16
  # 0123456789
  DIGITS[:decimal] = DIGITS[:dec] = :P10
  # 01234567
  DIGITS[:octal] = DIGITS[:oct] = DIGITS[:o] = :P8
  # 01
  DIGITS[:b] = DIGITS[:bin] = DIGITS[:binary] = :P2

  # !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
  DIGITS[:G94] = DIGITS[:g] = :graph

  # !#$%&()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_abcdefghijklmnopqrstuvwxyz{|}~
  DIGITS[:Q91] = DIGITS[:qgraph] = DIGITS[:q] = :'graph-quotes'

  # ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/
  DIGITS[:base64] = DIGITS[:b64] = DIGITS[:B64] = :LN_k43k47
  DIGITS[:letters] = DIGITS[:l] = :B52 # subset of B64

  # 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz
  DIGITS[:word] = DIGITS[:W63] = :w

  # 3479ACEFHJKLMNPRTUVWXYabcdefghijkmnopqrstuvwxyz
  DIGITS[:unambiguous] = DIGITS[:U47] = DIGITS[:u] = :'alnum-ambiguous'

  BASE = Base[
    # 95
    P95: 95,
    print: 95,
    # 94
    G94: 94, g: 94, graph: 94,
    # 91
    Q91: 91, qgraph: 91, q: 91,
    # 64
    B64: 64, base64: 64, b64: 64,
    # 63
    W63: 63, word: 63, w: 63,
    # 52
    letters: 52, l: 52, L: 52,
    # 47
    U47: 47, unambiguous: 47, u: 47,
    # 16
    hexadecimal: 16, hex: 16, h: 16,
    # 15
    ambiguous: 15,
    # 10
    decimal: 10, dec: 10, d: 10,
    # 9
    operators: 9,
    # 8
    octal: 8, oct: 8, o: 8,
    # 6
    groupers: 6,
    # 5
    separators: 5,
    # 4
    quoters: 4,
    # 3
    typers: 3,
    quotes: 3,
    # 2
    binary: 2, bin: 2, b: 2,
    bangs: 2,
    scapes: 2,
    spacers: 2,
  ]
end
