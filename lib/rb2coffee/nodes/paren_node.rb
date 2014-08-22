module Rb2coffee
  module Nodes
    class ParenNode < Node
      def after_initialize(sexp)
        @body = NodeFactory.make_node(sexp[1], self)
        @children = [@body]
      end

      def make_code
        code = '('
        code << @body.make_code
        code << ')'
      end
    end
  end
end