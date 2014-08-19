module Rb2js
  module Nodes
    class IdentNode < Node
      attr_reader :value
      def after_initialize(sexp)
        @value = sexp[1]
      end

      def make_code
        blockarg_name =  @context[:params] && @context[:params].blockarg ? @context[:params].blockarg.make_code : nil
        # rename block argument
        if blockarg_name == @value
          "#{@context[:function].name.make_code}._block"
        elsif @context[:class] && @parent.is_a?(FcallNode)
          @context[:local_scope] && @context[:local_scope].include?(@value) ? @value : "this.#{@value}"
        else
          @value
        end
      end
    end
  end
end