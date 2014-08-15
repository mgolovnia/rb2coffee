module Rb2js
  module Nodes
    class VoidStmtNode < Node
      def after_initialize(sexp)
      end

      def make_code
        ''
      end
    end
  end
end