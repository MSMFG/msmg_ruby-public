require 'minitest/autorun'
require 'builder_pattern'

class TestBuilder
  include BuilderPattern
  attr_mandatory :a
  attr_mandatory :b, :c
  attr_optional :d

  def initialize
    super
    @d = nil
  end

  def sum
    d = @d || 0
    @a + @b + @c + d
  end
end

# Unit Test
class TestBuilderPattern < Minitest::Test
  def test_working
    bp = TestBuilder.build do |opt|
      opt.a = 1
      opt.b = 2
      opt.c = 3
    end
    assert_equal(6, bp.sum)
  end

  def test_working_optional
    bp = TestBuilder.build do |opt|
      opt.a = 1
      opt.b = 2
      opt.c = 3
      opt.d = 4
    end
    assert_equal(10, bp.sum)
  end

  def test_missing
    assert_raises(ArgumentError) do
      TestBuilder.build do |opt|
        opt.a = 1
        opt.b = 2
      end
    end
  end

  def test_bad_attr
    assert_raises(ArgumentError) do
      TestBuilder.build do |opt|
        opt.a = 1
        opt.b = 2
        opt.c = 3
        opt.foo = 'hello'
      end
    end
  end
end
