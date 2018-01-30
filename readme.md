# Generic mixins

Released by MSM DevOps group under Apache 2.0 license

## ToHash

Add a to_hash method to any class that will produce a hash from all instance variables or that can be called with a parameter set of instance variables in string or symbol form.
By default the keys produced are symbols but when called with parameters it will use the parameter form passed for the keys (which can be mixed symbols and strings).
In order to make an alternate default of to_hash with a specific set of attributes one may consider implementing to_hash can calling a super method to pass the params i.e.

```
  class Foo
    include ToHash
  
    def initialize
      @foo = 1
      @bar = 2
      @boo = 3
    end

    def to_hash
      super(:foo, 'bar')
    end
  end

  Foo.new.to_hash == {
    :foo => 1,
    'bar' => 2
  }
```

## ComparableByAttr


Adds a default behaviour for <=> based upon instance variables within the class and includes Comparable to produce other comparison operators.
Instance variables by default are enumerated, sorted and stored in an array and the arrays are compared with their own l to r behaviour.
One may override the instance variables used in the comparison and the order by specifying an attr_compare override in the class definition.

```
  # instances will be comparable by [@a, @b, @c]
  class Bar
    include ComparableByAttr
  
    def initialize(a, b, c)
      @a = a
      @b = b
      @c = c
    end
  end
  
  # instances will be comparable by [@c, @a]
  class Bar
    include ComparableByAttr
    attr_compare :c, :a
  
    def initialize(a, b, c)
      @a = a
      @b = b
      @c = c
    end
  end
```

## dig

A backport of the Ruby 2.3.0 dig instance method for Hash and Array written in Ruby.

Since this code aims not to introduce unnecessary modules into the namespace and is targetted at extending Hash and Array directly it is not implemented as a Mixin but rather extends those classes directly using class_eval.

The Ruby module aims for compatibility based upon the specification stated in the C library comments (which are recorded within the unit test for convenience).

Documentation from Ruby 2.3.0 states..

Extracts the nested value specified by the sequence of idx objects by calling dig at each step, returning nil if any intermediate step is nil.

```
    h = { foo: {bar: {baz: 1}}}

    h.dig(:foo, :bar, :baz)           #=> 1
    h.dig(:foo, :zot, :xyz)           #=> nil

    g = { foo: [10, 11, 12] }
    g.dig(:foo, 1)                    #=> 11
```

## BuilderPattern
Implements a builder pattern to produce an object with a set of instance variables set.
Allows definition of mandatory and optional attributes that are enforced during build step for the object.

```
  class Foo
    include BuilderPattern
    attr_mandatory :a
    attr_mandatory :b, :c
    attr_optional :d

    def run
      puts "I'm running fine #{@a} #{@b} #{@c} #{@d}"
    end
  end

  a = Foo.build do |o|
    o.a = 1
    o.b = 2
    o.c = 3
  end
  a.run

=> I'm running fine 1 2 3

  a = Foo.build do |o|
    o.a = 1
    o.b = 2
  end
  a.run

=> `build': Mandatory fields @c not set (ArgumentError)
	from /Users/andrew.smith/Ruby/fooexample.rb:14:in `build'
	from /Users/andrew.smith/Ruby/fooexample.rb:43:in `<main>'

  a = Foo.build do |o|
    o.a = 1
    o.b = 2
    o.c = 3
    o.d = 'Hello'
  end
  a.run

=> I'm running fine 1 2 3 Hello

  a = Foo.build do |o|
    o.a = 1
    o.b = 2
    o.c = 3
    o.d = 'Hello'
    o.f = 'foo'
  end
  a.run

=> `block in build': Unknown field @f used in build (ArgumentError)

```
