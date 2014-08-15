module Rb2js
  module Nodes
    class ClassNode < Node
      attr_reader :name
      def after_initialize(sexp)
        @context.merge!({ class: self })
        @name = NodeFactory.make_node(sexp[1])
        # @superclass = NodeFactory.make_node(sexp[2])
        @body = NodeFactory.make_node(sexp[3], self, @context)
        @constructor = @body.find_node_by{|node| node.is_a?(DefNode) && node.name.make_code == 'initialize' }
      end

      def make_code
        class_name = @name.make_code
        code = "#{class_name} = (function(){\n"

        code << "function #{class_name}(){};\n" unless @constructor

        body_code = @body.make_code
        if body_code.size > 0
          code << body_code
          code << ";\n" if body_code[-1] != "\n" # avoid dupicate \n in nested statements
        end
        code << "return(#{class_name});\n"
        code << "})()"
        code
      end
    end
  end
end