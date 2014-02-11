require 'test/unit'
require 'base_convert'
require 'digest'

# Using my original tests on BASE_CONVERT::Number
class TestOriginal2 < Test::Unit::TestCase
  include BASE_CONVERT

  def test_001_to_s_n
    # test against number.to_s(base)
    2.upto(36) do |base|
      100.times do
        decimal  = rand(10000)

        decimal0 = decimal.to_s
        decimal1 = Number.new(decimal)
        assert_equal(decimal0, decimal1)

        base0 = decimal.to_s(base)
        base1 = decimal1.to_base(base)

        # BaseConvert uses caps
        assert_equal(base0.upcase, base1)
        assert_equal(decimal1, base1.to_base(10))
        # and it will automatically upcase
        assert_equal(decimal1, Number.new(base0, base).to_base(10))
      end
    end
  end

  def test_002_hello_world
    hexdigest = Number.new(Digest::SHA256.hexdigest('Hello World!'), :hex)
    # and verified below (BaseConvert uses uppecase for hexadeximals.
    assert_equal '7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069'.upcase, hexdigest

    #word = BaseConvert.new(:hex, :word).convert(hexdigest)
    word = hexdigest.to_base(:word)
    assert_equal 'UEjKBW7lvEq1KjyCxAYQRJqmvffQEbwLNvzs8Ggdy4P', word

    #assert_equal hexdigest.upcase, BaseConvert.new(:word, :hex).convert(word)
    assert_equal hexdigest, word.to_base(:hex)

    qstring = Number.new('$<c6PCX_mugC58xfO5JOp+V4|<jHekI^_WE$?d?9', :qgraph)
    # and verified below
    assert_equal '$<c6PCX_mugC58xfO5JOp+V4|<jHekI^_WE$?d?9', qstring
    #assert_equal qstring, BaseConvert.new(:hex, :qgraph).convert(hexdigest)
    assert_equal qstring, hexdigest.to_base(:qgraph)

    assert_equal hexdigest, qstring.to_base(:hex)
  end

  def test_003_hundred_million
    hudred_million = Number.new(100_000_000)
    assert_equal '100000000', hudred_million
    #assert_equal '6laZE', BaseConvert.new(10, 62).convert( 100_000_000 )
    assert_equal '6laZE', hudred_million.to_base(62)
    #assert_equal ')8]3H', BaseConvert.new(63).dec2base( 100_000_000 )
    assert_equal ')8]3H', hudred_million.to_base(63)

    #base = BaseConvert.new(62)
    #base.to_digits = BaseConvert::QGRAPH
    #assert_equal ')RGF1', base.dec2base( 100_000_000 )
    assert_equal ')RGF1', hudred_million.to_base(62, BaseConvert::QGRAPH)
  end

end
