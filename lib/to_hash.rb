# Generic ToHash mixin
module ToHash
  # to_hash generic implementation, generates a hash from object Mixing in this
  # module from instance variables of the object
  #
  # Example:
  #   class Foo
  #     include ToHash
  #     def initialize
  #       @a = 1
  #       @b = 2
  #       @c = 3
  #     end
  #   end
  #
  #   Foo.new.to_hash             #=> { :a => 1, :b => 2, :c => 3}
  #   Foo.new.to_hash(:c, 'a')    #=> { 'a' => 1, :c => 3 }
  #
  # Arguments:
  #   *keys: (Optional key list)
  def to_hash(*keys)
    keys = keys.any? ? __named_map(keys) : __instance_map
    keys = keys.map do |key, val|
      [key, instance_variable_get(val)]
    end
    Hash[keys]
  end

  private

  def __named_map(keys)
    keys = keys.map do |key|
      [key, "@#{key}".to_sym]
    end
    Hash[keys]
  end

  def __instance_map
    keys = instance_variables.map do |var|
      # Eliminate @ in naming key
      key = var.to_s.delete('@').to_sym
      [key, var]
    end
    Hash[keys]
  end
end
