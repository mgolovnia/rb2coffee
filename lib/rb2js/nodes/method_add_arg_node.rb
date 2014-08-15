
module Rb2js
  module Nodes
    class MethodAddArgNode < Node
      attr_reader :function_name
      def after_initialize(sexp)
        @function_name = NodeFactory.make_node(sexp[1], self)
        @arguments = NodeFactory.make_node(sexp[2], self)
        @children = [@function_name, @arguments]
      end

      def make_code(block = nil)
        code = ""
        code << @function_name.make_code
        code << '('
        code << @arguments.make_code
        code << ')'
        code
      end
    end
  end
end