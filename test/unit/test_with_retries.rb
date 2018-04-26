require 'minitest/autorun'
require 'with_retries'

# Unit Test
class TestWithRetries < Minitest::Test
  include WithRetries

  def test_no_exceptions
    fails = 3
    tries = 0
    with_retries(5) do
      tries += 1
      (fails -= 1).zero?
    end
    assert_equal(3, tries)
  end

  # rubocop:disable Metrics/MethodLength ok
  def test_exception_prop
    tries = 0
    # Inner block must wrap any errors that should not be immediately fatal
    # eventually they are propagated out as the original error
    assert_raises(StandardError) do
      with_retries(5) do
        begin
          tries += 1
          raise 'Error'
        rescue StandardError => ex
          raise WrappableError, ex
        end
      end
    end
    assert_equal(5, tries)
  end
  # rubocop:enable all
end
