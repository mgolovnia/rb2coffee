module Rb2js
  module Nodes
    class BraceBlockNode < Node
      def after_initialize(sexp)
        @var = NodeFactory.make_node(sexp[1], self)
        @body = NodeFactory.make_node(sexp[2][1], self)
        @params_node = @var.find_node_by { |child| child.is_a?(ParamsNode) }
        @last_computed_value = NodeFactory.make_node(sexp[2][2], self)
        @children = [@var, @body, @last_computed_value]
      end

      def make_code
        last_computed_value_code = @last_computed_value.make_code
        last_return = last_computed_value_code.include?('return')
        body_code = @body.make_code
        code = "function(){\n"
        @params_node.params_names.each_with_index do |param, index|
          code << "var #{param} = arguments[#{index}];\n"
        end
        if body_code.size > 0 && body_code != last_computed_value_code
          code << body_code
          code << ";\n" if body_code[-1] != "\n" # avoid dupicate \n in nested statements
        end
        code << "return(" unless last_return
        code << last_computed_value_code
        code << ";\n" if last_return
        code << ");\n" unless last_return
        code << "}"
        code
      end
    end
  end
end