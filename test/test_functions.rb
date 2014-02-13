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

end
