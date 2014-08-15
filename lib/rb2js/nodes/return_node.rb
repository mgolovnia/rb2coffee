module Rb2js
  module Nodes
    class ReturnNode < Node
      def after_initialize(sexp)
        @return_value = NodeFactory.make_node(sexp[1])
        @children = [@return_value]
      end

      def make_code
        code = "return"
        code << wrap_with_parenthesis(@return_value.make_code)
      end
    end
  end
end