module BaseConvert
  class Digits < Hash
    def initialize
      @registry = [:P95, :B64, :U47, :G94, :Q91, :W63]
    end

    # Set super's [] definition as get
    alias :get :[]
    def [](key)
      return (_=get key).is_a?(Symbol)?self[_]:_ if self.has_key? key
      case key
      when Symbol
        chars = Chars.new
        key.to_s.scan(/[+-]?[[:alnum:]]+/).each do |type|
          if self.has_key?(_=type.to_sym)
            chars.add super(_)
            next
          end
          case type
          when /^((u\h+)|(k\d+))+$/ # add single char by code
            type.scan(/[uk]\h+/).each{chars.top _1.to_sym}
          when /^(([ij]\d+)|([vw]\h+))+$/ # set start/stop range
            type.scan(/[ijvw]\h+/).each{chars.set _1}
          when /^[a-z][a-z]+$/ # add by POSIX bracket expression
            chars.add Regexp.new "[[:#{type}:]]"
          when /^[a-z]$/ # add by metacharacter
            chars.add Regexp.new "\\#{type}"
          when /^[A-Z]+$/i # add by property
            type.scan(/[A-Z][a-z]*/).each{chars.add(/\p{#{_1}}/)}
          when /^([+-])(\w+)$/ # top or remove chars of key given
            (_=self[$2.to_sym]) and ($1=='+')? chars.top(_): chars.remove(_)
          when /^(\p{L}+)(\d+)$/ # a registered set
            l,m = $1,$2.to_i-1
            n = self.keys.select{_1=~/^#{l}\d+$/}
              .map{_1.to_s.sub(l,'').to_i}.max
            raise "no #{l}<n> digits defined" if n.nil?
            raise "out of range of #{l}#{n}" unless m<n
            chars.add self[:"#{l}#{n}"][0..m]
          else
            raise "unrecognized digits key: #{type}"
          end
        end
        return chars.to_s.freeze
      when String
        _=@registry.lazy.map{self[_1]}.detect{_1.start_with? key} and return _
        raise 'need at least 2 digits' unless key.length > 1
        if key.length > key.chars.uniq.length
          raise 'digits must not have duplicates'
        end
        return key
      when Integer
        raise 'need digits to cover base' if key > 95
        return self[:P95] # Defined in configuration.rb
      end
      raise 'digits must be String|Symbol|Integer'
    end

    def registry(d=nil)
      # BaseConvert::Number memoizes and uses specifically :P95, :B64, and :U47;
      # giving these precedence above the rest.
      d ? @registry.detect{|_|self[_].start_with? d}: @registry
    end

    def label(d)
      registry(d) or (d[0..1]+d[-2..-1]).to_sym
    end

    def memoize!(keys=@registry)
      [*keys].each do |k|
        # follow Symbol links 'till nil|String
        while s=get(k) and not s.is_a? String
          raise 'expected Symbol' unless s.is_a? Symbol
          k = s
        end
        self[k]=self[k] unless s # memoize if needed
      end
    end

    def forget!(keys=@registry)
      [*keys].each do |k|
        # follow Symbol links 'till nil|String
        while s = get(k) and not s.is_a? String
          raise 'expected Symbol' unless s.is_a? Symbol
          k = s
        end
        self.delete(k) if s
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
