module Rb2coffee
  module Nodes
    class OneChildNode < Node

      def after_initialize(sexp)
        # use void_stmt when child is nil, e.g foo()
        @child = NodeFactory.make_node(sexp[1] || [:void_stmt], self, @context)
        @children = [@child]
      end

      def make_code
        @child.make_code
      end
    end
  end
end