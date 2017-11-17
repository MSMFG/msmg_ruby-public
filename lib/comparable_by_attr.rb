# Allow simple definitions for object comparisons
module ComparableByAttr
  include Comparable

  # rubocop:disable Metrics/MethodLength class_eval wrapper
  def self.included(klass)
    klass.class_eval do
      @__attr_precedence = nil

      # attr_compare allows selection of specific instance variables and order to use
      # within the comparison of objects created off the class
      #
      # Example:
      #   class IgnoreC
      #     include ComparableByAttr
      #     attr_compare :a, :b
      #
      #     def initialize(a, b, c)
      #       @a = a
      #       @b = b
      #       @c = c
      #     end
      #   end
      #
      # Arguments:
      #   *prec = (Optional Precedence Map)
      def self.attr_compare(*prec)
        attr_prec = prec.map do |attr|
          "@#{attr}".to_sym
        end
        @__attr_precedence = attr_prec
      end

      def <=>(other)
        prec = self.class.instance_variable_get(:@__attr_precedence)
        comp_order = prec || instance_variables.sort
        this = comp_order.map { |field| instance_variable_get(field) }
        that = comp_order.map { |field| other.instance_variable_get(field) }
        this <=> that
      end
    end
  end
end
