require 'test/unit'
require 'base_convert'

class TestBaseConvert < Test::Unit::TestCase
  include BASE_CONVERT
  include CONFIG

  def test_001_new
    wl = WORD.length

    base = BaseConvert.new(10, 16)
    assert base.from_digits.equal?(WORD)
    assert base.to_digits.equal?(WORD)

    base = BaseConvert.new(70, 8)
    assert base.from_digits.equal?(QGRAPH)
    assert base.to_digits.equal?(WORD)

    base = BaseConvert.new(wl, 90)
    assert base.from_digits.equal?(WORD)
    assert base.to_digits.equal?(QGRAPH)

    base = BaseConvert.new(wl+1, wl+2)
    assert base.from_digits.equal?(QGRAPH)
    assert base.to_digits.equal?(QGRAPH)

    base = BaseConvert.new(:word, :qgraph)
    assert base.from_digits.equal?(WORD)
    assert base.to_digits.equal?(QGRAPH)

    base = BaseConvert.new(:qgraph, :word)
    assert base.from_digits.equal?(QGRAPH)
    assert base.to_digits.equal?(WORD)

    a = base.base2dec('z')
    assert_equal(Fixnum, a.class)
    assert_equal(86, a)

    a = base.dec2base(16)
    assert_equal(String, a.class)
    assert_equal('G', a)

    a = base.convert('z')
    assert_equal(String, a.class)
    base = BaseConvert.new(:word, :qgraph)
    a = base.convert(a)
    assert_equal('z', a)

    base = BaseConvert.new(:hex, :oct)
    assert_equal('7777', base.convert('FFF'))
    assert_equal('7777', base.convert('fff')) # Tests the upcase convenience

    base = BaseConvert.new(:oct, :hex)
    assert_equal('FFF', base.convert('7777'))
  end
end
