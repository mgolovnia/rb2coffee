module Rb2coffee
  module Nodes
    class ProgramNode < Node
      attr_reader :last_computed_value

      def after_initialize(sexp)
        @hoistable_declarations = find_hoistable_declarations_raw(sexp)
        @body = NodeFactory.make_node(sexp[1], self, @context.merge({ local_scope: @hoistable_declarations }))
        @children = [@body]
      end

      def make_code(external_declarations = "")
        code = "(function(){\n"
        body_code = @body.make_code
        code << "var #{@hoistable_declarations.join(', ')};\n" if @hoistable_declarations.any?
        unless body_code.empty?
          code << body_code
        end
        code << "})();"
        code
      end

    end
  end
end