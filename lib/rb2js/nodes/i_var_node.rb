module Rb2js
  module Nodes
    class IVarNode < Node
      def after_initialize(sexp)
        @name = sexp[1]
      end

      def make_code
        @name.gsub('@', 'this.')
      end
    end
  end
end