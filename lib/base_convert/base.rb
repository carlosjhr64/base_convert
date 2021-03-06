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
end
