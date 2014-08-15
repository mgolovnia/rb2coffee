module Rb2js
  module Nodes
    class IdentNode < Node
      def after_initialize(sexp)
        @value = sexp[1]
      end

      def make_code
        blockarg_name =  @context[:params] && @context[:params].blockarg ? @context[:params].blockarg.make_code : nil
        # rename block argument
        if blockarg_name == @value
          "_#{@context[:fname].make_code}_block"
        else
          @value
        end
      end
    end
  end
end