module BaseConvert
  class Base < Hash
    alias :get :[]
    def [](key)
      base = super and return base
      case key
      when String
        base = key.length
      when Integer
        base = key
      when /^\D+(\d+)$/
        base = $1.to_i
      else
        begin
          base = DIGITS[key].length
        rescue
          raise 'unrecognized base key'
        end
      end
      raise 'base must be greater than 1' unless base > 1
      base
    end
  end
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
