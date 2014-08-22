module Rb2coffee
  module Nodes
    class BinaryNode < Node
      def after_initialize(sexp)
        @left_value = NodeFactory.make_node(sexp[1], self, @context)
        @right_value = NodeFactory.make_node(sexp[3], self, @context)
        @op = sexp[2].to_s
        @children = [@left_value, @right_value]
      end

      def make_code
        @left_value.make_code + ' ' + @op + ' ' + @right_value.make_code
      end
    end
  end
end