require 'test/unit'
require 'base_convert/config'
require 'base_convert/helpers'

class TestHelpers < Test::Unit::TestCase
  include BASE_CONVERT
  include CONFIG
  extend  HELPERS

  HEX  = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']

  def test_003_upcase
    assert(TestHelpers.upcase?(36, WORD))
    refute(TestHelpers.upcase?(36, HEX))
    refute(TestHelpers.upcase?(37, WORD))
  end

  def test_004_validate
    assert_raises(RuntimeError){ TestHelpers.validate(5.0, WORD) }
    assert_nothing_raised(Exception){ TestHelpers.validate(5, WORD) }

    assert_raises(RuntimeError){ TestHelpers.validate(5, '0123456789abdef') }
    assert_nothing_raised(Exception){ TestHelpers.validate(5, ['0', '1', '2', '3', '4']) }

    assert_raises(RuntimeError){ TestHelpers.validate(5, ['0', '1', '2', '3']) }
    assert_nothing_raised(Exception){ TestHelpers.validate(5, ['0', '1', '2', '3', '4', '5', '6']) }

    assert_raises(RuntimeError){ TestHelpers.validate(1, ['0', '1']) }
    assert_nothing_raised(Exception){ TestHelpers.validate(2, ['0', '1']) }
  end

  def test_005_validate_string
    assert_raises(RuntimeError){ TestHelpers.validate_string('xyz', 3, ['a','b','c']) }
    assert_nothing_raised(Exception){ TestHelpers.validate_string('xyz', 3, ['x','y','z']) }
    assert_nothing_raised(Exception){ TestHelpers.validate_string('xyz', 3, ['x','y','z','a','b','c']) }
    assert_raises(RuntimeError){ TestHelpers.validate_string('abc', 3, ['x','y','z','a','b','c']) }
    assert_nothing_raised(Exception){ TestHelpers.validate_string('abc', 6, ['x','y','z','a','b','c']) }
  end

  def test_006_digits
    wl = WORD.length

    a = TestHelpers.digits(wl)
    assert(a.equal?(WORD))

    a = TestHelpers.digits(wl+1)
    assert(a.equal?(QGRAPH))

    a = TestHelpers.digits(:word)
    assert(a.equal?(WORD))

    a = TestHelpers.digits(:qgraph)
    assert(a.equal?(QGRAPH))

    a = TestHelpers.digits(:hex)
    assert(a.equal?(WORD))

    DIGITS[:my_digits] = ['X','Y','Z']
    a = TestHelpers.digits(:my_digits)
    assert(a.equal?(DIGITS[:my_digits]))

    BASE[:my_base] = wl
    a = TestHelpers.digits(:my_base)
    assert(a.equal?(WORD))

    BASE[:my_base] = wl+1
    a = TestHelpers.digits(:my_base)
    assert(a.equal?(QGRAPH))
  end

  def test_007_base
    wl = WORD.length
    ql = QGRAPH.length

    a = TestHelpers.base(:word)
    assert_equal(wl, a)

    a = TestHelpers.base(:qgraph)
    assert_equal(ql, a)

    a = TestHelpers.base(:hex)
    assert_equal(16, a)
    a = TestHelpers.base(:hexadecimal)
    assert_equal(16, a)

    a = TestHelpers.base(:decimal)
    assert_equal(10, a)
    a = TestHelpers.base(:dec)
    assert_equal(10, a)

    a = TestHelpers.base(:octal)
    assert_equal(8, a)
    a = TestHelpers.base(:oct)
    assert_equal(8, a)

    a = TestHelpers.base(:binary)
    assert_equal(2, a)
  end
end
