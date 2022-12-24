module BaseConvert
  # Chars provides ways of populating an ordered(as constructed) set
  # with characters in UTF-8.
  class Chars
    def initialize
      @start,@stop,@a = 32,126,[]
    end

    attr_accessor :start,:stop
    def to_a = @a
    def to_s = @a.join

    # Chars can search a range in UTF-8 for character classes.
    # Use Chars#set to set the start and stop of the range.
    # i<n>: @start=n.to_i
    # v<n>: @start=n.to_i(16)
    # j<n>: @stop=n.to_i
    # w<n>: @stop=n.to_i(16)
    def set(s)
      unless /^([ij]\d+)|([vw]\h+)$/.match?(s)
        raise 'expected /^([ij]\d+)|([vw]\h+)$/'
      end
      t,n = s[0],s[1..-1]
      case t
      when 'i','v'
        @start = n.to_i((t=='v')? 16 : 10)
      when 'j','w'
        @stop = n.to_i((t=='w')? 16 : 10)
      end
    end

    def chars_in(x)
      case x
      when Regexp
        (@start..@stop).each{x.match?(c=_1.chr(Encoding::UTF_8)) && yield(c)}
      when Symbol
        yield x[1..-1].to_i((x[0]=='u')? 16: 10).chr(Encoding::UTF_8)
      when String
        x.chars.each{|c| yield c}
      when Integer
        yield x.chr(Encoding::UTF_8)
      else
        raise "expected Regexp|Symbol|String|Integer, got #{x.class}"
      end
    end

    def add(x)    = chars_in(x){@a.push _1 unless @a.include?_1}
    def top(x)    = chars_in(x){@a.delete _1;@a.push _1}
    def remove(x) = chars_in(x){@a.delete _1}
  end
end
