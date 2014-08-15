module Rb2js
  module Nodes
    class IntNode < Node
      def after_initialize(sexp)
        @value = sexp[1].to_i
      end

      def make_code
        @value.to_s
      end
    end
  end
end