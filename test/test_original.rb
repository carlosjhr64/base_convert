require 'test/unit'
require 'base_convert'
require 'digest'

class TestBaseConvert < Test::Unit::TestCase
  include BASE_CONVERT

  def test_001_to_s_n
    # test against number.to_s(n)
    2.upto(36) do |n|
      # Converts to base n.
      base = BaseConvert.new(n)
      100.times do
        number = rand(10000)
        string = number.to_s(n)
        # BaseConvert uses caps
        assert_equal(string.upcase, base.dec2base(number))
        # and it will automatically upcase
        assert_equal(number, base.base2dec(string))
      end
    end
  end

  def test_002_hello_world
    hexdigest = Digest::SHA256.hexdigest('Hello World!') # and verified below
    assert_equal '7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069', hexdigest

    word = BaseConvert.new(:hex, :word).convert(hexdigest)
    assert_equal 'UEjKBW7lvEq1KjyCxAYQRJqmvffQEbwLNvzs8Ggdy4P', word

    assert_equal hexdigest.upcase, BaseConvert.new(:word, :hex).convert(word)

    qstring = '$<c6PCX_mugC58xfO5JOp+V4|<jHekI^_WE$?d?9'
    assert_equal qstring, BaseConvert.new(:hex, :qgraph).convert(hexdigest)
    assert_equal hexdigest.upcase, BaseConvert.new(:qgraph, :hex).convert(qstring)
  end

  def test_003_hundred_million
    assert_equal '6laZE', BaseConvert.new(10, 62).convert( 100_000_000 )
    assert_equal ')8]3H', BaseConvert.new(63).dec2base( 100_000_000 )

    base = BaseConvert.new(62)
    base.to_digits = BaseConvert::QGRAPH
    assert_equal ')RGF1', base.dec2base( 100_000_000 )
  end

end
