module Rb2js
  module Nodes
    class StmtsAddNode < Node
      attr_reader :last_computed_value
      def after_initialize(sexp)
        @body = NodeFactory.make_node(sexp[1], self, @context)
        @stmts_new = sexp[1] == [:stmts_new]
        @last_computed_value = NodeFactory.make_node(sexp[2], self, @context)
        @children = [@body, @last_computed_value]
      end

      def make_code
        code = ""
        body_code = @body.make_code
        if body_code.size > 0
          code << body_code
          code << ";\n" if body_code[-1] != "\n" && !@stmts_new # avoid duplicate \n in nested statements
        end
        last_computed_value_code = @last_computed_value.make_code
        if last_computed_value_code.size > 0
          code << last_computed_value_code
          code << ";\n" if last_computed_value_code[-1] != "\n" && !@stmts_new # avoid duplicate \n in nested statements
        end
        code
      end
    end
  end
end