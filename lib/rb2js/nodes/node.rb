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

      def make_code_with_return
        code = make_code
        code = " #{make_code}" if code.size > 0
        "return#{code};\n"
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

    end
  end
end