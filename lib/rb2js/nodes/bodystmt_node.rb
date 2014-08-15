module Rb2js
  module Nodes
    class BodystmtNode < Node
      attr_reader :last_computed_value

      def after_initialize(sexp)
        @body = NodeFactory.make_node(sexp[1][1], self, @context)
        if sexp[1][2]
          @last_computed_value = NodeFactory.make_node(sexp[1][2], self, @context)
        else
          @last_computed_value = @body
        end
        @children = [@body, @last_computed_value].uniq
      end

      def make_code(external_declarations = "")
        if @context[:class] && !@context[:fname]
          class_body
        elsif @context[:class] && @context[:fname] && @context[:fname].make_code == 'initialize'
          constructor_body
        else
          function_body(external_declarations)
        end
      end

      private

      def class_body
        code = ''
        body_code = @body.make_code
        if body_code.size > 0
          code << body_code
          code << ";\n" if body_code[-1] != "\n" # avoid dupicate \n in nested statements
        end
        code << @last_computed_value.make_code
        code
      end

      def constructor_body
        last_computed_value_code = @last_computed_value.make_code
        last_return = last_computed_value_code.include?('return')
        body_code = @body.make_code
        code = ''
        code << "{\n"

        hoistable_declarations = find_hoistable_declarations.map{|node| node.is_a?(VarFieldNode) ? node.make_code : node.name.make_code }.uniq

        code << "var #{hoistable_declarations.join(', ')};\n" if hoistable_declarations.any?

        if body_code.size > 0
          code << body_code
          code << ";\n" if body_code[-1] != "\n" # avoid dupicate \n in nested statements
        end
        code << "#{last_computed_value_code};\n"
        code << "}"
        code
      end

      def function_body(external_declarations = "")
        last_computed_value_code = @last_computed_value.make_code
        last_return = last_computed_value_code.include?('return')
        body_code = @body.make_code
        code = ''
        code << "{\n"

        code << external_declarations if external_declarations.size > 0

        hoistable_declarations = find_hoistable_declarations.map{|node| node.is_a?(VarFieldNode) ? node.make_code : node.name.make_code }.uniq

        code << "var #{hoistable_declarations.join(', ')};\n" if hoistable_declarations.any?

        if body_code.size > 0
          code << body_code
          code << ";\n" if body_code[-1] != "\n" # avoid dupicate \n in nested statements
        end

        if last_return
          code << "#{last_computed_value_code};\n"
        else
          code << "return(#{last_computed_value_code});\n"
        end
        code << "}"
        code
      end

    end
  end
end