module Lotus
  module Utils
    class String < ::String
      def initialize(string)
        super(string.to_s)
      end

      def classify
        split('_').map {|token| token.slice(0).upcase + token.slice(1..-1) }.join
      end

      def underscore
        gsub('::', '/').
          gsub(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          downcase
      end

      def tokenize(&blk)
        template = gsub(/\((.*)\)/, "%{token}")
        tokens   = Array(( $1 || self ).split('|'))

        tokens.each do |token|
          blk.call(template % {token: token})
        end
      end
    end
  end
end
