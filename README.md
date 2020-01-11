# BaseConvert

* [VERSION 4.0.200111](https://github.com/carlosjhr64/base_convert/releases)
* [github](https://www.github.com/carlosjhr64/base_convert)
* [rubygems](https://rubygems.org/gems/base_convert)

## DESCRIPTION:

BaseConvert - Number base conversion.

Converts positive integers to different bases:
Binary, octal, hexadecimal, decimal, or any arbitrary base.
"Out of the box" handling of up to base 95(:print: characters).
Allows for arbitrary choice of alphabet(digits).

See also rosettacode.org's [Non-decimal radices convert](http://rosettacode.org/wiki/Non-decimal_radices/Convert).

## SYNOPSIS:

    require 'base_convert'

    #toi string, base, digits #=> integer
    BaseConvert.toi 'FF', 16, '0123456789ABCDEF' #=> 255

    #tos integer, base, digits #=> string
    BaseConvert.tos 255, 16, '0123456789ABCDEF' #=> "FF"

    # FromTo
    c = BaseConvert::FromTo.new base: 16, digits: '0123456789ABCDEF', to_base: 7, to_digits: 'abcdefg'
    c['FFF'] #=> "begea"
    c.inspect   #=> "16:P95,7:abfg"

    # Number
    n = BaseConvert::Number.new 'FF', base: 16, digits: '0123456789ABCDEF'
    n.to_i #=> 255
    n.to_s #=> "FF"
    n.inspect #=> FF 16:P95
    #
    n = n.to_base 64, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    n.to_s #=> "D/"
    n.to_i #=> 255
    n.inspect #=> D/ 64:B64

## INSTALL:

    $ gem install base_convert

## BUT WAIT, THERE'S MORE:

### module BaseConvert

* `#toi(string=to_s String, base=@base Integer, digits=@digits String) #=> Integer`
* `#tos(integer=to_i Integer, base=@base Integer, digits=@digits String) #=> String`
* `#ascii_ordered?(digits=@digits String) #=> TrueClass|FalseClass`

Exemplar:

    class MyClass
      include BaseConvert
      attr_accessor :to_s, :to_i, :base, :digits
    end

    obj = MyClass.new
    obj.digits = '!@#$%^&*()'
    obj.base = 10

    obj.to_s = '@'
    obj.toi #=> 1

    obj.to_i = 3
    obj.tos #=> "$"

    obj.ascii_ordered? #=> false
    obj.digits = 'ABCDEFGHIJKLMNOP'
    obj.ascii_ordered? #=> true

### Hash DIGITS

#### DIGITS methods

* `DIGITS.get(key Symbol) #=> String|Symbol|NilClass`
* `DIGITS.registry(digits=nil NilClass|String) #=> Array(Symbol)|Symbol`
* `DIGITS.label(digits String) #=> String`
* `DIGITS.memoize!(key=registry Symbol|Array(Symbol))`
* `DIGITS.forget!(key=registry Symbol|Array(Symbol))`


Exemplar:

    DIGITS.get(:P95) #=> :alnum_bangs_typers_operators_separators_scapes_groupers_quoters_spacers
    DIGITS[:P95]
    #=> "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!?$&@*+-/<=>^~,.:;|#\\()[]{}%\"'`_ "
    DIGITS.registry #=> [:P95, :B64, :U47, :G94, :Q91, :W63]
    DIGITS.registry('347') #=> :U47
    DIGITS.registry('0') #=> :P95
    DIGITS.registry('AB') #=> :B64
    DIGITS.registry('Cukoe') #=> nil
    DIGITS.label('Cukoe') #=> :Cuoe
    DIGITS.label('AaBbCcXxYyZz') #=> :AaZz
    DIGITS[:N] #=> "0123456789"
    DIGITS.get(:N) #=> nil
    DIGITS.memoize!(:N)
    DIGITS.get(:N) #=> "0123456789"
    DIGITS.forget!(:N)
    DIGITS.get(:N) #=> nil


#### DIGITS constructions

`BaseConvert::DIGITS` will take a `Symbol` representation of `Regexp` patterns.
See [Ruby-Doc's Regexp](https://ruby-doc.org/core-2.7.0/Regexp.html) documentation
for a full list of keys.  The following provides an exemplar survey:

    require 'base_convert'
    include BaseConvert

    # Character Classes
    # Selected from ASCII 32..126
    DIGITS[:w] #=> "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz"
    DIGITS[:d] #=> "0123456789"
    DIGITS[:h] #=> "0123456789ABCDEF" # Note this was overridden, see :xdigit.
    DIGITS[:alpha] #=> "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    DIGITS[:graph]
    #=> "!\"\#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
    DIGITS[:lower] #=> "abcdefghijklmnopqrstuvwxyz"
    DIGITS[:punct] #=> "!\"\#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
    DIGITS[:upper] #=> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    DIGITS[:xdigit] #=> "0123456789ABCDEFabcdef"

    # Character Properties
    # Selected from ASCII 32..126
    DIGITS[:Alnum] #=> "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    DIGITS[:Any]
    #=> " !\"\#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"

    # General Category
    # Selected from ASCII 32..126
    DIGITS[:Ps] #=> "([{"
    DIGITS[:Pe] #=> ")]}"
    DIGITS[:S] #=> "$+<=>^`|~"

    # Ranged Selections
    # v<hex>w<hex>_<filter>
    DIGITS[:v1d7d8w1d7e1_Any] #=> "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
    # i<dec>j<dec>_<filter>
    DIGITS[:i120488j120513_Any] #=> "𝚨𝚩𝚪𝚫𝚬𝚭𝚮𝚯𝚰𝚱𝚲𝚳𝚴𝚵𝚶𝚷𝚸𝚹𝚺𝚻𝚼𝚽𝚾𝚿𝛀𝛁"

    # Specified Characters
    # u<hex>
    DIGITS[:u61u62] #=> "ab"
    # k<dec>
    DIGITS[:k97k98] #=> "ab"

    # BaseConvert's Custom Sets
    DIGITS[:bangs] #=> "!?"
    DIGITS[:typers] #=> "$&@"
    DIGITS[:operators] #=> "*+-/<=>^~"
    DIGITS[:separators] #=> ",.:;|"
    DIGITS[:scapes] #=> "#\\"
    DIGITS[:groupers] #=> "()[]{}"
    DIGITS[:quotes] #=> "\"'`"
    DIGITS[:quoters] #=> "%\"'`"
    DIGITS[:spacers] #=> "_ "
    DIGITS[:ambiguous] #=> "012568BDGIOQSZl"

    # Composition, add merge:
    DIGITS[:d_ambiguous] #=> "0123456789BDGIOQSZl"
    # Composition, add top:
    DIGITS[:'d+ambiguous'] #=> "3479012568BDGIOQSZl"
    # Composition, subtract:
    DIGITS[:'d-ambiguous'] #=> "3479"

    # Compositions used in BaseConvert
    # :P95 is:
    DIGITS[:alnum_bangs_typers_operators_separators_scapes_groupers_quoters_spacers]
    #=> "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!?$&@*+-/<=>^~,.:;|#\\()[]{}%\"'`_ "
    # :B64 is:
    DIGITS[:LN_k43k47] #=> "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    # :U47 is:
    DIGITS[:'alnum-ambiguous'] #=> "3479ACEFHJKLMNPRTUVWXYabcdefghijkmnopqrstuvwxyz"

### class FromTo

* `new(base: 10 Integer|Symbol|String, to_base: base, digits: :P95 String|Symbol|Integer, to_digits: digits) #=> FromTo` 
* `#inspect #=> String`
* `#convert(counter String|Integer) #=> String`

Example:

    require 'base_convert'
    h2b = BaseConvert::FromTo.new(base: 16, digits: :P95, to_base: 64, to_digits: :B64)
    h2b #=> 16:P95,64:B64
    h2b['FFF'] #=> "//"
    b2h = BaseConvert::FromTo.new(base: 64, digits: :B64, to_base: 16, to_digits: :P95)
    b2h #=> 64:B64,16:P95
    b2h['//'] #=> "FFF"

### class Number

* `new(counter= 0 Integer|String, base: nil Integer|Symbol|String, digits: nil String|Symbol|Integer, validate: true TrueClass|FalseClass) #=> Number`
* `#base #=> Integer`
* `#digits #=> String`
* `#inspect #=> String`
* `#to_s #=> String`
* `#to_i #=> Integer`
* `#to_base(base Integer|Symbol|String, digits=@digits String|Symbol|Integer, validate=@validate TrueClass|FalseClass) #=> Number`
* `#to_digits(digits String|Symbol|Integer, base=@base Integer|Symbol|String, validate=@validate TrueClass|FalseClass) #=> Number`

Example:

    require 'base_convert'
    a = BaseConvert::Number.new('FFF', base: 16, digits: :P95)
    a #=> FFF 16:P95
    a.to_i #=> 4095
    b = a.to_digits(:U47)
    b #=> RRR 16:U47
    b.to_i #=> 4095
    c = b.to_base(64, :B64)
    c #=> // 64:B64
    c.to_i #=> 4095

## LICENSE:

(The MIT License)

Copyright (c) 2020 CarlosJHR64

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
