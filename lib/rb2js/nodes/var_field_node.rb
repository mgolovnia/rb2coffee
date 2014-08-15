module Rb2js
  module Nodes
    class VarFieldNode < OneChildNode
      def type
        return :ivar if @child.is_a?(IVarNode)
        return :ident if @child.is_a?(IdentNode)
      end
    end
  end
end