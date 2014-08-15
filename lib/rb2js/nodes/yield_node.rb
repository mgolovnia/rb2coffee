module Rb2js
  module Nodes
    class YieldNode < Node
      def after_initialize(sexp)
        @arguments = NodeFactory.make_node(sexp[1], self, @contexts)
      end

      def make_code
        code = "_#{@context[:fname].make_code}_block"
        code << wrap_with_parenthesis(@arguments.make_code)
      end
    end
  end
end