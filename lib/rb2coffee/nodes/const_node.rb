module Rb2coffee
  module Nodes
    class ConstNode < Node
      def after_initialize(sexp)
        @name = sexp[1]
      end

      def make_code
        @name.gsub('@', '')
      end
    end
  end
end