module Lotus
  module Utils
    module Concern
      def append_features(base)
        super
        
        mixin_class_methods
        fire_included_callback
      end

      def included(base = nil, &block)
        if base.nil?
          @_included_block = block
        else
          super
        end
      end
      
      private
      
      def mixin_class_methods(base)
        if const_defined?(:ClassMethods)
          base.extend const_get(:ClassMethods)
        end
      end
      
      def fire_included_callback(base)
        if instance_variable_defined?(:@_included_block)
          base.class_eval(&@_included_block)          
        end
      end
    end
  end
end