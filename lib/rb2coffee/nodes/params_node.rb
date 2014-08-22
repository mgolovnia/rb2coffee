module Rb2coffee
  module Nodes
    class ParamsNode < Node
      attr_reader :initialized_params, :uninitialized_params, :rest_param, :blockarg
      def after_initialize(sexp)
        @uninitialized_params = []
        @initialized_params = []
        sexp[1].to_a.each_with_index do |param_node, indx|
          @uninitialized_params << NodeFactory.make_node(param_node, self, @context)
        end
        sexp[4].to_a.each_with_index do |param_node, indx|
          @uninitialized_params << NodeFactory.make_node(param_node, self, @context)
        end
        sexp[2].to_a.each_with_index do |param_node, indx|
          @initialized_params << [NodeFactory.make_node(param_node[0], self), NodeFactory.make_node(param_node[1], self)]
        end
        @rest_param = NodeFactory.make_node(sexp[3])

        @blockarg = NodeFactory.make_node(sexp[5]) if sexp[5]

        @children = [@uninitialized_params, @initialized_params, @rest_param].flatten
      end

      def rest_param?
        !@rest_param.nil?
      end

      def params_names
        return @names.flatten if @names
        @names = []
        @names << @uninitialized_params.map(&:make_code) if @uninitialized_params.any?
        @names << @initialized_params.map{ |param| param.first.make_code } if @initialized_params.any?
        @names << @rest_param.make_code if @rest_param
        @names.flatten
      end

      def make_code
        return '' if rest_param?
        params_names.join(', ')
      end
    end
  end
end