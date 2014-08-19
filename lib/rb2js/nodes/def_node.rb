module Rb2js
  module Nodes
    class DefNode < Node
      attr_reader :name, :full_name
      def after_initialize(sexp)
        @name = NodeFactory.make_node(sexp[1], self)
        @params = NodeFactory.make_node(sexp[2], self, @context.merge({ function: self }) )
        @params_node = @params.find_node_by { |child| child.is_a?(ParamsNode) }
        @rest_param = @params.find_node_by { |child| child.is_a?(RestParamNode) }
        @body = NodeFactory.make_node(sexp[3], self, @context.merge({ params: @params_node, function: self  }))
        @children = [@name, @params, @body]
      end

      def make_code
        code = ''
        if is_constructor?
          code << make_constructor
        elsif is_instance_method?
          code << make_method
        else
          code << make_function
        end

        params = @params.is_a?(ParenNode) ? @params.make_code : "(#{@params.make_code})"
        code << params
        params_declarations = ""
        if @rest_param
          params_names = @params_node.params_names
          params_declarations = "var #{params_names.join(', ')};\n"
          rest_param_name = @rest_param.make_code
          rest_param_index = params_names.size - 1
          if params_names.size > 1
            params_names[0..rest_param_index - 1].each_with_index {|pname, index| params_declarations << "#{pname} = arguments[#{index}];\n"}
          end
          rest_param_desclaration = "#{rest_param_name} = #{params_names.size} <= arguments.length ? Array.prototype.slice.call(arguments, #{rest_param_index}) : [];\n"
          params_declarations << rest_param_desclaration
        end
        #initialize parameters
        @params_node.initialized_params.each do |param_name, param_value|
          param_name = param_name.make_code
          param_value = param_value.make_code
          params_declarations << "#{param_name} = typeof #{param_name} !== 'undefined' ? #{param_name} : #{param_value};\n"
        end

        code << @body.make_code(params_declarations)
        code
      end

      def make_code_with_return
        code = make_code
        code << ";\n"
        code << "return #{@name.make_code};\n"
      end

      def full_name
        is_instance_method? ? "#{@context[:class].name.make_code}.prototype.#{@name.make_code}" : @name.make_code
      end

      def is_constructor?
        @context[:class] && @name.make_code == 'initialize'
      end

      def is_instance_method?
        @context[:class] && !@context[:function]
      end

      private

      def make_method
        "#{@context[:class].name.make_code}.prototype.#{@name.make_code} = function"
      end

      def make_function
        "#{@name.make_code} = function"
      end

      def make_constructor
        "function #{@context[:class].name.make_code}"
      end

    end
  end
end