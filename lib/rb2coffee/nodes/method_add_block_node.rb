
module Rb2coffee
  module Nodes
    class MethodAddBlockNode < Node
      def after_initialize(sexp)
        @method_arg = NodeFactory.make_node(sexp[1], self, @context)
        @block = NodeFactory.make_node(sexp[2], self, @context)
        @function_name = @method_arg.find_node_by{|node| node.is_a?(FcallNode) } if @method_arg
        @children = [@method_arg, @block]
      end

      def make_code
        code = ""
        block_name = @context[:class] ? "#{@context[:class].name.make_code}.prototype.#{@function_name.raw_name}._block" : "#{@function_name.make_code}._block"
        code << "#{block_name} = #{@block.make_code};\n"
        code << @method_arg.make_code(@block)
      end

      def make_code_with_return
        code = ""
        block_name = @context[:class] ? "#{@context[:class].name.make_code}.prototype.#{@function_name.raw_name}._block" : "#{@function_name.make_code}._block"
        code << "#{block_name} = #{@block.make_code};\n"
        code << "return #{@method_arg.make_code(@block)};\n"
      end
    end
  end
end