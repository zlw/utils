require 'test_helper'
require 'lotus/utils/concern'

module Foo
  extend Lotus::Utils::Concern
  
  module ClassMethods
    def foo
      'foo'
    end
  end
end

module Bar
  extend Lotus::Utils::Concern
  
  def bar
    'bar'
  end
end

module FoobarMixin
  extend Lotus::Utils::Concern
  
  included do
    include Foo
    include Bar
  end
end

class Foobar
  include FoobarMixin
end

describe Lotus::Utils::Concern do
  it 'mixins methods in ClassMethods module as class methods' do
    klass = Class.new do
      include Foo
    end

    klass.foo.must_equal 'foo'
  end
  
  it 'mixins methods as instance methods' do
    klass = Class.new do
      include Bar
    end
    
    klass.new.bar.must_equal 'bar'
  end
  
  it 'fires included callback' do
    klass = Class.new do
      include FoobarMixin
    end
    
    klass.foo.must_equal 'foo'
    klass.new.bar.must_equal 'bar'
  end
end


  