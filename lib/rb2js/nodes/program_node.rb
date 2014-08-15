module Rb2js
  module Nodes
    class ProgramNode < Node
      attr_reader :last_computed_value

      def after_initialize(sexp)
        @body = NodeFactory.make_node(sexp[1], self)
        @children = [@body]
      end

      def make_code(external_declarations = "")
        code = ''
        hoistable_declarations = find_hoistable_declarations.map{|node| node.is_a?(VarFieldNode) ? node.make_code : node.name.make_code }.uniq
        body_code = @body.make_code
        code << "var #{hoistable_declarations.join(', ')};\n" if hoistable_declarations.any?
        unless body_code.empty?
          code << body_code
        end
        code
      end

    end
  end
end