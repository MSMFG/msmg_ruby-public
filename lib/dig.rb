# Hash/Array #dig backport from Ruby 2.3.0
# Dig method is common to Array and Hash
[[], {}].each do |obj|
  next if obj.respond_to?(:dig)
  obj.class.class_eval do
    # dig for values in Array/Hash
    #
    # Example:
    #   g = { foo: [10, 11, 12] }
    #   g.dig(:foo, 1)              #=> 11
    #
    # Arguments:
    #   *keys: (Accessor List)
    def dig(*keys)
      elem = self[keys.shift]
      return elem if keys.empty? || elem.nil?
      return elem.dig(*keys) if elem.respond_to?(:dig)
      raise TypeError, "#{elem.class} does not have a #dig method"
    end
  end
end
