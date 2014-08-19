module Rb2js
  module Nodes
    class NodeFactory
      class UnknownNodeError < StandardError; end;
      def self.make_node(sexp, parent = nil, context = {})
        return unless sexp && sexp[0]
        klass = case sexp[0]
        when :arg_paren
          ArgParenNode
        when :args_add_block
          ArgsAddBlockNode
        when :args_add
          ArgsAddNode
        when :args_new
          ArgsNewNode
        when :assign
          AssignNode
        when :begin
          BeginNode
        when :binary
          BinaryNode
        when :block_var
          BlockVarNode
        when :blockarg
          BlockargNode
        when :bodystmt
          BodystmtNode
        when :brace_block
          BraceBlockNode
        when :class
          ClassNode
        when :@const
          ConstNode
        when :const_ref
          ConstRefNode
        when :def
          DefNode
        when :do_block
          DoBlockNode
        when :fcall
          FcallNode
        when :@ivar
          IVarNode
        when :@ident
          IdentNode
        when :@int
          IntNode
        when :method_add_arg
          MethodAddArgNode
        when :method_add_block
          MethodAddBlockNode
        when :params
          ParamsNode
        when :paren
          ParenNode
        when :program
          ProgramNode
        when :rest_param
          RestParamNode
        when :return
          ReturnNode
        when :stmts_add
          StmtsAddNode
        when :stmts_new
          StmtsNewNode
        when :var_field
          VarFieldNode
        when :var_ref
          VarRefNode
        when :void_stmt
          VoidStmtNode
        when :yield0
          Yield0Node
        when :yield
          YieldNode
        else
          raise UnknownNodeError, sexp[1]
        end
        klass.new(sexp, parent, context)
      end
    end
  end
end