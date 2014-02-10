require 'test/unit'
require 'base_convert/config'
require 'base_convert/functions'

class TestFunctions < Test::Unit::TestCase
  include BASE_CONVERT
  include CONFIG
  extend  FUNCTIONS

  HEX  = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']

  def test_001_to_integer
    a = TestFunctions.to_integer('0', 16, HEX)
    assert_equal(0, a)
    a = TestFunctions.to_integer('a', 16, HEX)
    assert_equal(10, a)
    a = TestFunctions.to_integer('f', 16, HEX)
    assert_equal(15, a)
    a = TestFunctions.to_integer('abcdef', 16, HEX)
    assert_equal(11259375, a)
  end

  def test_002_to_base
    a = TestFunctions.to_base(0, 16, WORD)
    assert_equal('0', a)
    a = TestFunctions.to_base(10, 16, WORD)
    assert_equal('A', a)
    a = TestFunctions.to_base(15, 16, WORD)
    assert_equal('F', a)
    a = TestFunctions.to_base(11259375, 16, WORD)
    assert_equal('ABCDEF', a)
  end

  def test_003_upcase
    assert(TestFunctions.upcase?(36, WORD))
    refute(TestFunctions.upcase?(36, HEX))
    refute(TestFunctions.upcase?(37, WORD))
  end

  def test_004_validate
    assert_raises(RuntimeError){ TestFunctions.validate(5.0, WORD) }
    assert_nothing_raised(Exception){ TestFunctions.validate(5, WORD) }

    assert_raises(RuntimeError){ TestFunctions.validate(5, '0123456789abdef') }
    assert_nothing_raised(Exception){ TestFunctions.validate(5, ['0', '1', '2', '3', '4']) }

    assert_raises(RuntimeError){ TestFunctions.validate(5, ['0', '1', '2', '3']) }
    assert_nothing_raised(Exception){ TestFunctions.validate(5, ['0', '1', '2', '3', '4', '5', '6']) }

    assert_raises(RuntimeError){ TestFunctions.validate(1, ['0', '1']) }
    assert_nothing_raised(Exception){ TestFunctions.validate(2, ['0', '1']) }
  end

  def test_005_validate_string
    assert_raises(RuntimeError){ TestFunctions.validate_string('xyz', 3, ['a','b','c']) }
    assert_nothing_raised(Exception){ TestFunctions.validate_string('xyz', 3, ['x','y','z']) }
    assert_nothing_raised(Exception){ TestFunctions.validate_string('xyz', 3, ['x','y','z','a','b','c']) }
    assert_raises(RuntimeError){ TestFunctions.validate_string('abc', 3, ['x','y','z','a','b','c']) }
    assert_nothing_raised(Exception){ TestFunctions.validate_string('abc', 6, ['x','y','z','a','b','c']) }
  end

  def test_006_digits
    wl = WORD.length

    a = TestFunctions.digits(wl)
    assert(a.equal?(WORD))

    a = TestFunctions.digits(wl+1)
    assert(a.equal?(QGRAPH))

    a = TestFunctions.digits(:word)
    assert(a.equal?(WORD))

    a = TestFunctions.digits(:qgraph)
    assert(a.equal?(QGRAPH))

    a = TestFunctions.digits(:hex)
    assert(a.equal?(WORD))

    DIGITS[:my_digits] = ['X','Y','Z']
    a = TestFunctions.digits(:my_digits)
    assert(a.equal?(DIGITS[:my_digits]))

    BASE[:my_base] = wl
    a = TestFunctions.digits(:my_base)
    assert(a.equal?(WORD))

    BASE[:my_base] = wl+1
    a = TestFunctions.digits(:my_base)
    assert(a.equal?(QGRAPH))
  end

  def test_007_base
    wl = WORD.length
    ql = QGRAPH.length

    a = TestFunctions.base(:word)
    assert_equal(wl, a)

    a = TestFunctions.base(:qgraph)
    assert_equal(ql, a)

    a = TestFunctions.base(:hex)
    assert_equal(16, a)
    a = TestFunctions.base(:hexadecimal)
    assert_equal(16, a)

    a = TestFunctions.base(:decimal)
    assert_equal(10, a)
    a = TestFunctions.base(:dec)
    assert_equal(10, a)

    a = TestFunctions.base(:octal)
    assert_equal(8, a)
    a = TestFunctions.base(:oct)
    assert_equal(8, a)

    a = TestFunctions.base(:binary)
    assert_equal(2, a)
  end
end
