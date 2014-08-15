module Rb2js
  module Nodes
    class AssignNode < Node
      def after_initialize(sexp)
        @left_value = NodeFactory.make_node(sexp[1], self, @context)
        @right_value = NodeFactory.make_node(sexp[2], self, @context)
        @children = [@left_value, @right_value]
      end

      def make_code
        @left_value.make_code + ' = ' + @right_value.make_code
      end
    end
  end
end