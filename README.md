# BaseConvert

* [github](https://www.github.com/carlosjhr64/base_convert)
* [rubygems](https://rubygems.org/gems/base_convert)

## DESCRIPTION:

BaseConvert - Number base conversion.

Converts positive integers to different bases:
Binary, octal, hexadecimal, decimal, or any arbitrary base.
"Out of the box" handling of up to base 94.
Allows for arbitrary choice of alphabet(digits).

See also rosettacode.org's [Non-decimal radices convert](http://rosettacode.org/wiki/Non-decimal_radices/Convert).

## SYNOPSIS:

    require 'base_convert'
    include BaseConvert
    h2o = FromTo.new(16, 8)
    o2h = FromTo.new(8, 16)
    a = h2o.convert('FFFF') #=> "177777"
    b = o2h.convert('177777') #=> "FFFF"

## BUT WAIT, THERE'S MORE:

Using `irb` to demonstrate the features.
The components are scoped under `BaseConvert`:

    # irb
    # Welcome to IRB...
    require 'base_convert' #=> true
    include BaseConvert #=> Object

`base_convert` provides three ways to convert a string representation of a number.
The first is functional.  One can extend(import) the functions that do the conversions.
The conversion functions are `to_integer` and `to_base`.
For example, the octal number "7777":

    extend Functions #=> main
    digits = '01234567'
    base = digits.length #=> 8
    to_integer('7777', base, digits) #=> 4095
    to_base(4095, base, digits) #=> "7777"

You can work with arbitrary digits:

    digits = ')!@#$%^&'
    base = digits.length #=> 8
    to_integer('&&&&', base, digits) #=> 4095
    to_base(4095, base, digits) #=> "&&&&"

For convenience, `base_convert` provides some predefined sets of digits.
`GRAPH` are the ASCII graph characters.
`QGRAPH` are the ASCII graph characters except quotes: double-quote, single-quote, and back-tick.
`WORD_` are the ASCII word characters including underscore(_).
`WORD` are the ASCII word characters except underscore(_).
`UNAMBIGUOUS` are the characters in `WORD` without the `AMBIGUOUS` characters(B8G6I1l0OQDS5Z2).

    Configuration::WORD #=> "01...AB...ab...yz"
    Configuration::QGRAPH #=> "!#...01...AB...ab...}~"
    to_base(4095, 8, Configuration::WORD) #=> "7777"
    to_base(4095, 8, Configuration::QGRAPH) #=> "****"

The second way to convert is via a conversion object of `BaseConvert::FromTo`.
For example, to convert from hexadecimal to octal, and back:

    h2o = FromTo.new(16, 8)
    o2h = FromTo.new(8, 16)
    h2o.convert('FFFF') #=> "177777"
    o2h.convert('177777') #=> "FFFF"

You can access the conversion alphabets via
the accessors `FromTo#from_digits` and `FromTo#to_digits`.
By default, WORD is used for bases upto 62.
For bigger bases upto 91, QGRAPH is used.
You can have bigger bases, but
you will need to come up with a bigger alphabet, perhaps
by adding greek letters.
Note that when there's no ambiguity while using WORD,
FromTo will upcase the string.

    h2o.convert('FFFF') #=> "177777"
    h2o.convert('ffff') #=> "177777"

FromTo also makes available the intermediary methods that works with integers,
FromTo#base2integer and FromTo#integer2Base:

    h2o.base2integer('FFFF') #=> 65535
    h2o.integer2base(65535) #=> "177777"

The third way to convert is via the subclass of String, `BaseConvert::Number`:

    hexadecimal = Number.new('FFFF', 16, Configuration::WORD) #=> "FFFF"
    # WORD is the default alphabet
    hexadecimal = Number.new('FFFF', 16) #=> "FFFF"
    hexadecimal.to_integer #=> 65535
    # The default base is 10.
    decimal = Number.new('65535') # "65535"
    decimal.to_integer #=> 65535
    decimal.to_base(16) #=> "FFFF"
    decimal.to_base(8) #=> "177777"
    # You can also specify the digits to use
    digits = ')!@#$%^&'
    decimal.to_base(8, digits) #=> "!&&&&&"

## Keys (Symbols)

Instead of stating the base number, one can use a mnemonic key:

    graph:       GRAPH
    qgraph:      QGRAPH
    word_:       WORD_
    word:        WORD
    unambiguous: UNAMBIGUOUS
    hexadecimal: 16
    hex:         16
    decimal:     10
    dec:         10
    octal:       8
    oct:         8
    binary:      2

The mnemonic key has the advantage of especifying both the base number and the digits to be used.
Examples:

    > require 'base_convert' # => true
    > BaseConvert::Number.new('FF',  :hex).to_base(:dec)            #=> "255"
    > BaseConvert::Number.new('255', :dec).to_base(:qgraph)         #=> "$m"
    > BaseConvert::Number.new('$m',  :qgraph).to_base(:unambiguous) #=> "CX"
    > BaseConvert::Number.new('CX',  :unambiguous).to_base(:oct)    #=> "377"
    > BaseConvert::Number.new('377', :oct).to_base(:hexadecimal)    #=> "FF"

## New in 2.2.0

I forgot to map the new digit sets added in 2.1.0 to a key, as listed above.

## New in 2.1.0

    # GRAPH.length == 94
    # !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~

    # WORD_.length == 63
    # 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz

    # UNAMBIGUOUS.length == 47
    # 3479ACEFHJKLMNPRTUVWXYabcdefghijkmnopqrstuvwxyz

## INSTALL:

    $ sudo gem install base_convert

## LICENSE:

(The MIT License)

Copyright (c) 2014 CarlosJHR64

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
