require 'ostruct'

# BuilderPattern module
module BuilderPattern
  # rubocop:disable Metrics/MethodLength because of class_eval
  def self.included(klass)
    klass.class_eval do
      private_class_method :new

      @__attr_mandatory = []
      @__attr_optional = []

      def self.attr_mandatory(*fields)
        @__attr_mandatory |= fields.map { |field| "@#{field}".to_sym }
      end

      def self.attr_optional(*fields)
        @__attr_optional |= fields.map { |field| "@#{field}".to_sym }
      end

      def self.build(&block)
        new.build(&block)
      end
    end
  end
  # rubocop:enable all

  # rubocop:disable Metrics/MethodLength desired single method, readable enough
  # rubocop:disable Metrics/AbcSize      desired single method, readable enough
  def build
    collector = OpenStruct.new
    yield collector
    mandatory = self.class.instance_variable_get(:@__attr_mandatory)
    allowed = self.class.instance_variable_get(:@__attr_optional) | mandatory
    # Migrate the state to instance variables
    collector.each_pair do |key, val|
      key = "@#{key}".to_sym
      unless allowed.include?(key)
        raise ArgumentError, "Unknown field #{key} used in build"
      end
      instance_variable_set(key, val)
    end
    fields = mandatory - instance_variables
    return self if fields.empty?
    raise ArgumentError, "Mandatory fields #{fields.join(', ')} not set"
  end
  # rubocop:enable all
end
