module Rb2js
  module Nodes
    class Yield0Node < Node
      def after_initialize(sexp)
      end

      def make_code
        "_#{@context[:fname].make_code}_block()"
      end
    end
  end
end