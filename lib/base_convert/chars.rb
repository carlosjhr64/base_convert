module BaseConvert
  # Chars provides ways of populating an ordered set with characters in UTF-8.
  class Chars
    attr_accessor :start,:stop
    def initialize(start=32, stop=126)
      @start,@stop = start,stop
      @a = []
    end

    def to_a
      @a
    end

    def to_s
      @a.join
    end

    # i<n>: @start=n.to_i
    # v<n>: @start=n.to_i(16)
    # j<n>: @stop=n.to_i
    # w<n>: @stop=n.to_i(16)
    def set(s)
      t,n = s[0],s[1..-1]
      case t
      when 'i','v'
        @start = n.to_i((t=='v')? 16 : 10)
      when 'j','w'
        @stop = n.to_i((t=='w')? 16 : 10)
      else
        raise 'expected /^([ij]\d+)|([vw]\h+)$/'
      end
    end

    def chars_in(x)
      case x
      when Regexp
        @start.upto(@stop).each do |l|
          c = l.chr(Encoding::UTF_8)
          yield c if x.match? c
        end
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

    def add(x)
      chars_in(x) do |c|
        @a.push(c) unless @a.include?(c)
      end
    end

    def top(x)
      chars_in(x) do |c|
        @a.delete(c)
        @a.push(c)
      end
    end

    def remove(x)
      chars_in(x){|c| @a.delete(c)}
    end
  end
end
