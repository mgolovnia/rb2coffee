module Rb2js
  module Nodes
    class BodystmtNode < Node
      attr_reader :last_computed_value

      def after_initialize(sexp)
        @hoistable_declarations = find_hoistable_declarations_raw(sexp)
        @context.merge!({ local_scope: @hoistable_declarations })
        @body = NodeFactory.make_node(sexp[1][1], self, @context)
        if sexp[1][2]
          @last_computed_value = NodeFactory.make_node(sexp[1][2], self, @context)
        else
          @last_computed_value = @body
        end
        @sexp = sexp
        @children = [@body, @last_computed_value].uniq
      end

      def make_code(external_declarations = "")
        if is_class?
          class_body
        elsif is_constructor?
          constructor_body
        else
          function_body(external_declarations)
        end
      end

      private

      def is_class?
        @context[:class] && !@context[:function]
      end

      def is_constructor?
        @context[:class] && @context[:function] && @context[:function].name.make_code == 'initialize'
      end

      def class_body
        code = ''
        code << "_extend(#{ @context[:class].name.make_code }, #{ @context[:superclass].make_code });\n" if @context[:superclass]
        body_code = @body.make_code
        if body_code.size > 0
          code << body_code
          code << ";\n" if body_code[-1] != "\n" # avoid dupicate \n in nested statements
        end
        code << last_return
        code
      end

      def constructor_body
        body_code = @body.make_code
        code = ''
        code << "{\n"
        code << "var #{@hoistable_declarations.join(', ')};\n" if @hoistable_declarations.any?

        if body_code.size > 0
          code << body_code
          code << ";\n" if body_code[-1] != "\n" # avoid dupicate \n in nested statements
        end
        code << last_return
        code << ";\n}"
        code
      end

      def function_body(external_declarations = "")
        body_code = @body.make_code
        code = ''
        code << "{\n"

        code << external_declarations if external_declarations.size > 0

        code << "var #{@hoistable_declarations.join(', ')};\n" if @hoistable_declarations.any?

        if body_code.size > 0
          code << body_code
          code << ";\n" if body_code[-1] != "\n" # avoid dupicate \n in nested statements
        end
        code << last_return
        code << "}"
        code
      end

      def last_return
        if (is_constructor? || is_class?) || (@sexp[1][2] && @sexp[1][2][0] == :return)
          @last_computed_value.make_code
        elsif @sexp[1][2] && @sexp[1][2][0] == :def
          #implicitly return function
          @last_computed_value.make_code_with_return
        # elsif @sexp[1][2] && @sexp[1][2][0] == :method_add_block
          #implicitly return block call
          # ''
        else
          #implicitly return last value
          @last_computed_value.make_code_with_return
        end
      end

    end
  end
end