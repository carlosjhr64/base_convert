require 'test/unit'
require 'base_convert'

class TestTrivial < Test::Unit::TestCase

  def test_001_version
    assert_not_nil BASE_CONVERT::VERSION=~/^\d+\.\d+\.\d+$/
  end

  def test_002_qgraph
    a = BASE_CONVERT::CONFIG::QGRAPH
    assert_equal(91, a.length)
    refute(a.include?('"'))
    refute(a.include?("'"))
    assert_equal('!', a.first)
  end

  def test_003_word
    a = BASE_CONVERT::CONFIG::WORD
    assert_equal(62, a.length)
    refute(a.include?('_'))
    assert_equal('0', a.first)
    assert_equal(36, BASE_CONVERT::CONFIG::INDEXa)
    assert_equal('a', a[36])
  end

  def test_004_base
    a = BASE_CONVERT::CONFIG::BASE
    assert_equal(Hash, a.class)
    assert_equal(62, a[:word])
    assert_equal(91, a[:qgraph])
    assert_equal(16, a[:hex])
    assert_equal(16, a[:hexadecimal])
    assert_equal(10, a[:decimal])
    assert_equal(10, a[:dec])
    assert_equal(8,  a[:octal])
    assert_equal(8,  a[:oct])
    assert_equal(2,  a[:binary])
  end

  def test_005_digits
    a = BASE_CONVERT::CONFIG::DIGITS
    assert_equal(Hash, a.class)
    assert(a[:word].equal?(BASE_CONVERT::CONFIG::WORD))
    assert(a[:qgraph].equal?(BASE_CONVERT::CONFIG::QGRAPH))
  end

end
