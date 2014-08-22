module Rb2coffee
  module Nodes
    class Yield0Node < Node
      def after_initialize(sexp)
      end

      def make_code
        "#{@context[:function].name.make_code}._block()"
      end
    end
  end
end