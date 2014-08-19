require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestNodeFactory < MiniTest::Unit::TestCase

      def test_it_raises_exception_in_case_of_unknown_node
        assert_raises(NodeFactory::UnknownNodeError){  NodeFactory.make_node([:some_node]) }
      end

      def test_it_returns_nil_in_case_of_nil
        assert_nil NodeFactory.make_node([])
      end

      def test_it_creates_arg_paren_node
        assert_kind_of ArgParenNode, NodeFactory.make_node([:arg_paren])
      end

      def test_it_creates_args_add_block_node
        assert_kind_of ArgsAddBlockNode, NodeFactory.make_node([:args_add_block])
      end

      def test_it_creates_args_add_node
        assert_kind_of ArgsAddNode, NodeFactory.make_node([:args_add])
      end

      def test_it_creates_args_new_node
        assert_kind_of ArgsNewNode, NodeFactory.make_node([:args_new])
      end

      def test_it_creates_assign_node
        assert_kind_of AssignNode, NodeFactory.make_node([:assign])
      end

      def test_it_creates_begin_node
        assert_kind_of BeginNode, NodeFactory.make_node([:begin])
      end

      def test_it_creates_binary_node
        assert_kind_of BinaryNode, NodeFactory.make_node([:binary])
      end

      def test_it_creates_block_var_node
        assert_kind_of BlockVarNode, NodeFactory.make_node([:block_var])
      end

      def test_it_creates_blockarg_node
        assert_kind_of BlockargNode, NodeFactory.make_node([:blockarg])
      end

      def test_it_creates_bodystmt_node
        assert_kind_of BodystmtNode, NodeFactory.make_node([:bodystmt, []])
      end

      def test_it_creates_brace_block_node
        assert_kind_of BraceBlockNode, NodeFactory.make_node([:brace_block,[:block_var, [:params, nil, nil, nil, nil, nil], nil],
                                                             [:stmts_add, [:stmts_new], [:void_stmt]]])
      end

      def test_it_creates_call_node
        assert_kind_of CallNode, NodeFactory.make_node([:call, []])
      end

      def test_it_creates_class_node
        assert_kind_of ClassNode, NodeFactory.make_node([:class, [:const_ref, [:@const, "C"]], nil, [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]])
      end

      def test_it_creates_const_node
        assert_kind_of ConstNode, NodeFactory.make_node([:@const])
      end

      def test_it_creates_const_ref_node
        assert_kind_of ConstRefNode, NodeFactory.make_node([:const_ref])
      end

      def test_it_creates_def_node
        assert_kind_of DefNode, NodeFactory.make_node([:def, [:@ident, "foo", [1, 4]], [:params, nil, nil, nil, nil],
                                                      [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]])
      end

      def test_it_creates_do_block_node
        assert_kind_of DoBlockNode, NodeFactory.make_node([:do_block,[:block_var, [:params, nil, nil, nil, nil, nil], nil],
                                                          [:stmts_add, [:stmts_new], [:void_stmt]]])
      end

      def test_it_creats_fcall_node
        assert_kind_of FcallNode, NodeFactory.make_node([:fcall])
      end

      def test_it_creates_ivar_node
        assert_kind_of IVarNode, NodeFactory.make_node([:@ivar])
      end

      def test_it_creates_ident_node
        assert_kind_of IdentNode, NodeFactory.make_node([:@ident])
      end

      def test_it_creates_int_node
        assert_kind_of IntNode, NodeFactory.make_node([:@int])
      end

      def test_it_creates_method_add_arg_node
        assert_kind_of MethodAddArgNode, NodeFactory.make_node([:method_add_arg])
      end

      def test_it_creates_method_add_block_node
        assert_kind_of MethodAddBlockNode, NodeFactory.make_node([:method_add_block])
      end

      def test_it_creates_params_node
        assert_kind_of ParamsNode, NodeFactory.make_node([:params])
      end

      def test_it_creates_paren_node
        assert_kind_of ParenNode, NodeFactory.make_node([:paren])
      end

      def test_it_creates__program_node
        assert_kind_of ProgramNode, NodeFactory.make_node([:program, [], nil, nil, nil])
      end

      def test_it_creates_return_node
        assert_kind_of ReturnNode, NodeFactory.make_node([:return])
      end

      def test_it_creates_stmts_add_node
        assert_kind_of StmtsAddNode, NodeFactory.make_node([:stmts_add])
      end

      def test_it_creates_stmts_new_node
        assert_kind_of StmtsNewNode, NodeFactory.make_node([:stmts_new])
      end

      def test_it_creates_var_field_node
        assert_kind_of VarFieldNode, NodeFactory.make_node([:var_field])
      end

      def test_it_creates_var_ref_node
        assert_kind_of VarRefNode, NodeFactory.make_node([:var_ref])
      end

      def test_it_creates_void_stmt_node
        assert_kind_of VoidStmtNode, NodeFactory.make_node([:void_stmt])
      end

      def test_it_creates_yield0_node
        assert_kind_of Yield0Node, NodeFactory.make_node([:yield0])
      end

      def test_it_creates_yield_node
        assert_kind_of YieldNode, NodeFactory.make_node([:yield])
      end
    end
  end
end
