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
          type.scan(/[A-Z][a-z]*/).each{|property| chars.add /\p{#{property}}/}
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
          n = self.keys.select{|_|_=~/^#{l}\d+$/}.map{|_|_.to_s.sub(l,'').to_i}.max
          raise "no #{l}<n> digits defined" if n.nil?
          raise "out of range of #{l}#{n}" unless m<n
          chars.add self[:"#{l}#{n}"][0..m]
        else
          raise "unrecognized digits key: #{type}"
        end
      end
      return chars.uniq.join.freeze
    when String
      digits = nil # set as a side effect...
      unless registry.detect{|_|(digits=self[_]).start_with? key}
        # ...here -------------->^^^^^
        raise 'need at least 2 digits' unless key.length > 1
        raise 'digits must not have duplicates' if key.length > key.chars.uniq.length
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
end
