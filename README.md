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

    #toi string, base, digits #=> integer
    BaseConvert.toi 'FF', 16, '0123456789ABCDEF' #=> 255

    #tob integer, base, digits #=> string
    BaseConvert.tob 255, 16, '0123456789ABCDEF' #=> "FF"

    # FromTo
    c = BaseConvert::FromTo.new base: 16, digits: '0123456789ABCDEF', to_base: 7, to_digits: 'abcdefg'
    c['FFF'] #=> "begea"

    # Number
    n = BaseConvert::Number.new 'FF', base: 16, digits: '0123456789ABCDEF'
    n.to_i #=> 255
    n.to_s #=> "FF"
    #
    n = n.to_base 64, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    n.to_s #=> "D/"
    n.to_i #=> 255

## BUT WAIT, THERE'S MORE:

Using `irb` to demonstrate the features.
The components are scoped under `BaseConvert`:

    > irb
    Welcome to IRB...
    >> require 'base_convert' #=> true
    >> include BaseConvert #=> Object

`base_convert` provides three ways to convert a string representation of a number.
The first is functional.  One can extend(import) the functions that do the conversions.
The conversion functions are `toi` and `tob`.
For example, the octal number "7777":

    extend BaseConvert #=> main
    digits = '01234567'
    base = digits.length #=> 8
    toi('7777', base, digits) #=> 4095
    tob(4095, base, digits) #=> "7777"

You can work with arbitrary digits:

    digits = ')!@#$%^&'
    base = digits.length #=> 8
    toi('&&&&', base, digits) #=> 4095
    tob(4095, base, digits) #=> "&&&&"

For convenience, `base_convert` provides under `module BaseConvert::Configuration` some predefined sets of digits.

* `GRAPH` are the ASCII graph characters.
* `QGRAPH` are the ASCII graph characters except quotes: double-quote, single-quote, and back-tick.
* `BASE64` is the standard base 64 digits from people with no sense of order.
* `WORD_` are the ASCII word characters including underscore(`_`).
* `WORD` are the ASCII word characters except underscore(`_`).
* `UNAMBIGUOUS` are the characters in `WORD` without the `AMBIGUOUS` characters(B8G6I1l0OQDS5Z2).

    Configuration::UNAMBIGUOUS #=> "3479ACEFHJKLMNPRTUVWXYabcdefghijkmnopqrstuvwxyz"
    # etc...
    tob 255, 16, Configuration::WORD #=> "FF"
    include Configuration
    tob 255, 64, BASE64 #=> "D/"

The second way to convert is via a conversion object of `BaseConvert::FromTo`.
For example, to convert from hexadecimal to octal, and back:

    h2o = FromTo.new base: 16, to_base: 8
    o2h = FromTo.new base: 8, to_base: 16
    h2o['FFFF'] #=> "177777"
    o2h['177777'] #=> "FFFF"

The third way to work with alternate base is via the `BaseConvert::Number`:

    hexadecimal = Number.new('FFFF', base: 16, digits: WORD)
    hexadecimal.to_s #=> "FFFF"
    hexadecimal.to_i #=> 65535

    # Number will infer your most likely meaning:
    Number.new('FF', 16).to_i #=> 255

    # And given a string of at least length 8,
    # it'll go ahead and guess at your meaning:
    Number.new('FFFFFFFF').to_i #=> 4294967295

    # But best practice is to fully specify,
    # which is easy to do with keys:
    n = Number.new 'F', base: :hex, digits: :word
    n.to_i #=> 15
    n.to_s #=> "F"

    # One can make of change of digits:
    n = n.to_digits '0123456789abcdef'
    n.to_s #=> "f"
    n.to_i #=> 15

    # One can make of change of base:
    n = n.to_base 8
    n.to_s #=> "17"

    # One can make of change of base and digits:
    n = n.to_base 32, :base64
    # or vice-versa
    n = n.to_digits :base64, 32
    n.to_s #=> "P"

## Keys (Symbols)

Instead of giving the base number or the digits' string,
one can use a mnemonic key:

| long key       | short key | DIGITS        | BASE NUMBER |
| -------------- | --------- | ------------- | ----------- |
| `:graph`       | `:g`      | `GRAPH`       | 94          |
| `:qgraph`      | `:q`      | `QGRAPH`      | 91          |
| `:base64`      | `:b64`    | `BASE64`      | 64          |
| `:word_`       | `:w_`     | `WORD_`       | 63          |
| `:word`        | `:w`      | `WORD`        | 62          |
| `:unambiguous` | `:u`      | `UNAMBIGUOUS` | 47          |

| long key       | short keys | BASE NUMBER |
| -------------- | ---------- | ----------- |
| `:hexadecimal` | `:hex, :h` | 16          |
| `:decimal`     | `:dec, :d` | 10          |
| `:octal`       | `:oct, :o` |  8          |
| `:binary`      | `:bin, :b` |  2          |


## INSTALL:

    $ gem install base_convert

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
