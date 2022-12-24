module BaseConvert
  class Digits < Hash
    alias :get :[]
    def [](key)
      if self.has_key?(key)
        d = super(key)
        return d.is_a?(Symbol)? self[d]: d
      end
      case key
      when Symbol
        chars = Chars.new
        key.to_s.scan(/[+-]?[[:alnum:]]+/).each do |type|
          if self.has_key?(_=type.to_sym)
            chars.add super(_)
            next
          end
          case type
          when /^((u\h+)|(k\d+))+$/
            type.scan(/[uk]\h+/).each{|s| chars.top s.to_sym}
          when /^(([ij]\d+)|([vw]\h+))+$/
            type.scan(/[ijvw]\h+/).each{|s| chars.set s}
          when /^[a-z][a-z]+$/
            chars.add Regexp.new "[[:#{type}:]]"
          when /^[a-z]$/
            chars.add Regexp.new "\\#{type}"
          when /^[A-Z]+$/i
            type.scan(/[A-Z][a-z]*/)
              .each{|property| chars.add(/\p{#{property}}/)}
          when /^([+-])(\w+)/
            d = self[$2.to_sym]
            case $1
            when '+'
              chars.top d
            when '-'
              chars.remove d
            end
          when /^(\p{L}+)(\d+)$/
            l,m = $1,$2.to_i-1
            n = self.keys
              .select{|_|_=~/^#{l}\d+$/}.map{|_|_.to_s.sub(l,'').to_i}.max
            raise "no #{l}<n> digits defined" if n.nil?
            raise "out of range of #{l}#{n}" unless m<n
            chars.add self[:"#{l}#{n}"][0..m]
          else
            raise "unrecognized digits key: #{type}"
          end
        end
        return chars.to_s.freeze
      when String
        digits = nil # set as a side effect...
        unless registry.detect{|_|(digits=self[_]).start_with? key}
          # ...here -------------->^^^^^
          raise 'need at least 2 digits' unless key.length > 1
          if key.length > key.chars.uniq.length
            raise 'digits must not have duplicates'
          end
          return key
        end
        return digits
      when Integer
        raise 'need digits to cover base' if key > 95
        return self[:P95] # Defined in configuration.rb
      end
      raise 'digits must be String|Symbol|Integer'
    end

    def registry(d=nil)
      # BaseConvert::Number memoizes and uses specifically :P95, :B64, and :U47;
      # giving these precedence above the rest.  Defined in configuration.rb.
      @registry ||= [:P95, :B64, :U47, :G94, :Q91, :W63]
      d ? @registry.detect{|_|self[_].start_with? d}: @registry
    end

    def label(d)
      registry(d) or (d[0]+d[1]+d[-2]+d[-1]).to_sym
    end

    def memoize!(keys=registry)
      [*keys].each do |k|
        while s = get(k)
          break if s.is_a? String # links to a constructed String
          raise 'expected Symbol' unless s.is_a? Symbol
          k = s
        end
        self[k]=self[k] if s.nil? # if not memoized, memoize!
      end
    end

    def forget!(keys=registry)
      [*keys].each do |k|
        while s = get(k)
          break if s.is_a? String # links to a constructed String
          raise 'expected Symbol' unless s.is_a? Symbol
          k = s
        end
        self.delete(k) if s.is_a? String
      end
    end
  end
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
end
