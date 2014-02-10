require 'test/unit'
require 'base_convert'

class TestBaseConvert < Test::Unit::TestCase
  include BASE_CONVERT
  include CONFIG

  def test_001_new
    a = Number.new(100)
    assert_equal '100', a
    a = Number.new('100')
    assert_equal '100', a
    assert_equal 100, a.to_integer

    assert_raises(RuntimeError){ Number.new('FFF') }
    a = Number.new('FFF', 16)
    assert_equal 'FFF', a
    assert_equal '7777', a.to_base(8)
    assert_equal 'FFF', a.to_base(8).to_base(16)
  end
end
