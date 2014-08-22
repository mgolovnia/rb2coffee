module Rb2coffee
  module Nodes
    class CallNode < Node
      def after_initialize(sexp)
        @var = NodeFactory.make_node(sexp[1])
        @method = NodeFactory.make_node(sexp[3])
        @children = [@var, @method]
      end

      def make_code
        code = ''
        if is_constructor?
          code << "new #{@var.make_code}"
        else
          code << "#{@var.make_code}.#{@method.make_code}"
        end
        code
      end

      private

      def is_constructor?
        @method.make_code == 'new'
      end
    end
  end
end