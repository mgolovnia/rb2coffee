module Rb2js
  module Nodes
    class Node
      include Helpers
      attr_reader :parent, :children
      def initialize(sexp, parent = nil, context = {})
        @parent = parent
        @children = []
        @context = context
        after_initialize(sexp)
      end

      protected

      def after_initialize(sexp)
        raise NotImplementedError
      end

      def make_code
        raise NotImplementedError
      end

      def find_node_by(&block)
        return self if block.call(self)
        @children.compact.each do |child|
          result = child.find_node_by(&block)
          return result if result
        end
        return nil
      end

      def find_all_nodes_by(res = [], &block)
        res << self if block.call(self)
        @children.compact.each do |child|
          result = child.find_all_nodes_by(res, &block)
          res + result if result
        end
        return res
      end

      def find_hoistable_declarations(res = [])
        return (res << self) if is_a?(DefNode) || (is_a?(VarFieldNode) && type == :ident ) || is_a?(ClassNode)
        @children.compact.each do |child|
          result = child.find_hoistable_declarations(res)
          res + result if result
        end
        return res
      end

      def sub_node_with(node, &block)

      end
    end
  end
end