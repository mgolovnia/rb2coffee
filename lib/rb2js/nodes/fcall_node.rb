module Rb2js
  module Nodes
    class FcallNode < OneChildNode
      def raw_name
        @child.value
      end
    end
  end
end