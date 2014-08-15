module Rb2js
  module Nodes
    class IVarNode < Node
      def after_initialize(sexp)
        @name = sexp[1]
      end

      def make_code
        "this.#{@name.gsub('@','')}"
      end
    end
  end
end