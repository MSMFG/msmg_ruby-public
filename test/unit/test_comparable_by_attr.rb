# Test classes

require 'comparable_by_attr'

# Test class
class APrecB
  include ComparableByAttr

  def initialize(a, b)
    @a = a
    @b = b
  end
end

# Test class
class BPrecA
  include ComparableByAttr
  attr_compare :b, :a

  def initialize(a, b)
    @a = a
    @b = b
  end
end

# Test class
class IgnoreC
  include ComparableByAttr
  attr_compare :a, :b

  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c
  end
end

# Unit Test
require 'minitest/autorun'

# rubocop:disable Lint/UselessComparison Unit Test
# Unit test
class TestComparableByAttr < Minitest::Test
  def test_a_gt_b_aprecb
    assert(APrecB.new(2, 1) > APrecB.new(1, 2))
  end

  def test_a_lt_b_aprecb
    assert(APrecB.new(1, 2) < APrecB.new(2, 1))
  end

  def test_a_n_gt_b_aprecb
    refute(APrecB.new(1, 2) > APrecB.new(1, 2))
  end

  def test_a_gt_b_bpreca
    assert(BPrecA.new(1, 2) > BPrecA.new(2, 1))
  end

  def test_a_eq_b_ignorec
    assert(IgnoreC.new(1, 1, 2) == IgnoreC.new(1, 1, 2))
  end
end
