module Rb2coffee
  module Nodes
    class BraceBlockNode < Node
      def after_initialize(sexp)
        @var = NodeFactory.make_node(sexp[1], self)
        @body = NodeFactory.make_node(sexp[2][1], self)
        @params_node = @var.find_node_by { |child| child.is_a?(ParamsNode) }
        @last_computed_value = NodeFactory.make_node(sexp[2][2], self)
        if sexp[2][2]
          @last_return = sexp[2][2][0] == :return
        else
          @last_return = nil
        end
        @children = [@var, @body, @last_computed_value]
      end

      def make_code
        body_code = @body.make_code
        code = "function(){\n"
        @params_node.params_names.each_with_index do |param, index|
          code << "var #{param} = arguments[#{index}];\n"
        end
        if body_code.size > 0
          code << body_code
          code << ";\n" if body_code[-1] != "\n" # avoid dupicate \n in nested statements
        end
        if @last_return
          code << @last_computed_value.make_code
        else
          code << @last_computed_value.make_code_with_return
        end
        code << "}"
        code
      end
    end
  end
end