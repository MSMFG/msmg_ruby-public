# Unit test for #dig

# Contract from hash.c in Ruby 2.3.0 and later..
# rubocop:disable Metrics/LineLength original documentation
# /*
# * call-seq:
# *   hsh.dig(key, ...)                 -> object
# *
# * Extracts the nested value specified by the sequence of <i>key</i>
# * objects by calling +dig+ at each step, returning +nil+ if any
# * intermediate step is +nil+.
# *
# *   h = { foo: {bar: {baz: 1}}}
# *
# *   h.dig(:foo, :bar, :baz)     #=> 1
# *   h.dig(:foo, :zot, :xyz)     #=> nil
# *
# *   g = { foo: [10, 11, 12] }
# *   g.dig(:foo, 1)              #=> 11
# *   g.dig(:foo, 1, 0)           #=> TypeError: Integer does not have #dig method
# *   g.dig(:foo, :bar)           #=> TypeError: no implicit conversion of Symbol into Integer
# */
# rubocop:enable all

require 'minitest/autorun'
require 'dig'

# Unit Test
class TestDig < Minitest::Test
  def setup
    @h = { foo: { bar: { baz: 1 } } }
    @g = { foo: [10, 11, 12] }
  end

  def test_hash_hash_hash
    assert_equal(1, @h.dig(:foo, :bar, :baz))
  end

  def test_hash_miss_miss
    assert_nil(@h.dig(:foo, :zot, :xyz))
  end

  def test_hash_array_fixnum_typerror
    assert_raises(TypeError) do
      @g.dig(:foo, 1, 0)
    end
  end

  def test_hash_array_symbol_typerror
    assert_raises(TypeError) do
      @g.dig(:foo, :bar)
    end
  end
end
