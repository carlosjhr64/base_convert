module BaseConvert
class Entropia < Number
  def Entropia.bits_length_entropy(bits_request, base)
    n,e,entropy = 0,1,2**bits_request
    while e < entropy
      n += 1
      e *= base
    end
    b=Math.log(e,2)
    # Actual bits, length, and entropy
    return b,n,e
  end

  attr_reader :bits, :length, :entropy
  def initialize(counter=nil, base: 95, digits: :P95, validate: true,
                 bits: 256, rng: Random)
    @bits,@length,@entropy = Entropia.bits_length_entropy(bits,base)
    counter = rng.random_number(@entropy) unless counter
    super(counter, base:base, digits:digits, validate:validate)
  end

  def to_s
    (@length - (string=tos).length).times{string.prepend self.digits[0]}
    return string
  end
end
end
