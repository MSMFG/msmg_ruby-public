# Generic WithRetries mixin

# Use to propagate exceptions from the inner block to with_retries handler
class WrappableError < StandardError
  attr_reader :wrapped

  def initialize(ex)
    super
    @wrapped = ex
  end
end

# Generic WithRetries mixin
module WithRetries
  # Generic with_retries method
  # rubocop:disable Metrics/MethodLength
  def with_retries(retries, operation: 'Operation',
                   log_method: Kernel.method(:puts))
    attempt = 1
    last_ex = nil
    loop do
      begin
        rval = yield
        last_ex = nil
        return rval if rval
      rescue WrappableError => ex
        # Stash the wrapped exception for later use
        last_ex = ex.wrapped
      end
      log_method.call "#{operation} failed #{attempt}/#{retries} attempts"
      break if (attempt += 1) > retries
    end
    log_method.call "#{operation} attempts totally failed"
    raise last_ex if last_ex
    nil
  end
  # rubocop:enable all
end
