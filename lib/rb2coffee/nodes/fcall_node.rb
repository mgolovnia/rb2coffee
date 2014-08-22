module Rb2coffee
  module Nodes
    class FcallNode < OneChildNode
      def raw_name
        @child.value
      end
    end
  end
end