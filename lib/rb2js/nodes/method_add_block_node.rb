
module Rb2js
  module Nodes
    class MethodAddBlockNode < Node
      def after_initialize(sexp)
        @method_arg = NodeFactory.make_node(sexp[1])
        @block = NodeFactory.make_node(sexp[2])
        @function_name = @method_arg.find_node_by{|node| node.is_a?(FcallNode) } if @method_arg
        @children = [@method_arg, @block]
      end

      def make_code
        code = ""
        code << "var _#{@function_name.make_code}_block = #{@block.make_code};\n"
        code << @method_arg.make_code(@block)
      end
    end
  end
end