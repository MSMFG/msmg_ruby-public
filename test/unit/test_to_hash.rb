# Test Classes
require 'to_hash'

# Test Class
class TestClass
  include ToHash

  def initialize
    @foo = 1
    @bar = 2
    @moo = 'three'
  end
end

require 'minitest/autorun'

# Unit test
class TestToHash < Minitest::Test
  def test_no_param
    expected = {
      foo: 1,
      bar: 2,
      moo: 'three'
    }
    assert_equal expected, TestClass.new.to_hash
  end

  def test_limited_text
    expected = {
      'foo' => 1,
      'moo' => 'three'
    }
    assert_equal expected, TestClass.new.to_hash('foo', 'moo')
  end

  # Of course with hash ordering is not important and neith should be
  # the order provided to the parameterisation
  def test_mixed_keys
    expected = {
      'moo' => 'three',
      foo: 1,
      bar: 2
    }
    assert_equal expected, TestClass.new.to_hash(:foo, 'moo', :bar)
  end
end
