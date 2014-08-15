module Rb2js
  module Nodes
    class ArgsAddNode < Node
      def after_initialize(sexp)
        @args = []
        @args << NodeFactory.make_node(sexp[1])
        @args << NodeFactory.make_node(sexp[2])
        @children = @args
      end

      def make_code
        @args.reject{ |node| node.is_a?(ArgsNewNode) }.map(&:make_code).join(', ')
      end
    end
  end
end