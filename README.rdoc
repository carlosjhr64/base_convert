# BaseConvert
# DESCRIPTION:
# Got the code originally from
#	http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
# which I then converted to a class.
# SINOPSIS:

def ok(a,b)
  raise "bad! /#{a}/ == /#{b}/" unless a == b
end

# ruby -I ./lib README.txt
if RUBY_VERSION =~ /^1.9.2/ then
  require 'base_convert'

  # Verify it works up to base 36 with number.to_s(n)
  2.upto(36) do |n|
    base = BaseConvert.new(n)
    100.times do
      number = rand(10000)
      string = number.to_s(n)
      ok( base.convert(string), number  )
      ok( base.convert(number), string.upcase  ) # BaseConvert uses caps
    end
  end

  # BaseConvert is case insensitive up to base 36, but
  # returns string values with capital leters.  
  # At base 37 and up, it's case sensitive with lower case letter being of higher order.
  # It primary use is to reduce digest strings.
  # For example:
  require 'digest'
  # This hexadecimal:
  ok(	"7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069",
	hexdigest = Digest::SHA256.hexdigest('Hello World!') )
  # Translatates to this word(\w except '_') string
  ok(	string = 'UEjKBW7lvEq1KjyCxAYQRJqmvffQEbwLNvzs8Ggdy4P',
	BaseConvert.new(:hexadecimal,:word).convert(hexdigest) )
  # and we can covert it back:
  ok(	BaseConvert.new(:word,:hexadecimal).convert(string),
	hexdigest.upcase )
  # Again, note the BaseConvert returns the hexdigest string capitalized.
  #There is also a quotable string([[:graph:]] except [`'"]):
  ok(	qstring = '$<c6PCX_mugC58xfO5JOp+V4|<jHekI^_WE$?d?9',
	BaseConvert.new(:hexadecimal,:qgraph).convert(hexdigest))
  # And you can convert it back
  ok(	BaseConvert.new(:qgraph,:hexadecimal).convert(qstring),
	hexdigest.upcase)
  # Note the length
  ok(	64, hexdigest.length)
  ok(	43, string.length)
  ok(	40, qstring.length)

  # BaseConvert has the following primary form:
  #	# converting from basefrom to baseto
  #	base = BaseConvert.new( basefrom, baseto )
  #	# covert basefrom_string in basefrom to baseto_string in baseto
  #	baseto_string = base.convert( basefrom_string )
  #	# convert basefrom_string to it's decimal number representation
  #	decimal_number = base.base2dec( basefrom_string )
  #	# convert a decimal_number to it's baseto string representation
  #	baseto_string = base.dec2base( decimal_number )
  # BaseConvert has the following heuristic forms:
  #	# converting to and from _base_
  #	base = BaseConvert.new( _base_ )
  #	base_string = base.convert( decimal_number )
  #	decimal_number = base.convert( base_string )
  # BaseConvert has the following mneumonic keys that can be use for base:
  #	:binary	=> 2
  #	:oct,:octal => 8,
  #	:dec,:decimal => 10,
  #	:hex,:hexadecimal => 16
  # BaseConvert's base can go up to 62 with :word(\w except '_') and 91 with :qgraph([:graph] except [`'"].
  # By default, :word is used...
  ok(	'6laZE', BaseConvert.new(62).convert( 100_000_000 ))
  # ...until a transition to :qgraph is required.
  ok(	')8]3H', BaseConvert.new(63).convert( 100_000_000 ))
  # But you can specify the digit dictionary. At this point you've read and know the code...
  base = BaseConvert.new(62)
  base.to_digits = BaseConvert::QGRAPH
  ok(	')RGF1', base.convert( 100_000_000 ))
end
# The End.
# <i>carlosjhr64</i>@<i>gmail<i/>.<i>com</i>
