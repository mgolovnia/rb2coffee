
require_relative '../../test_helper'

module Rb2coffee
  module Nodes
    class TestStmtsAddNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_empty_string
        sexp = [:stmts_add, [:stmts_new], [:void_stmt]]
        assert_equal '', StmtsAddNode.new(sexp).make_code
      end

      def test_it_compiles_into_last_computed_value
        sexp = [:stmts_add, [:stmts_new], [:binary, [:@int, "1", [1, 0]], :+, [:@int, "2", [1, 2]]]]
        assert_equal "1 + 2", StmtsAddNode.new(sexp).make_code
      end

      def test_it_compiles_into_stmt_body_and_last_computed_value
        sexp = [:stmts_add, [:stmts_add, [:stmts_new], [:@int, "1", [1, 0]]], [:binary, [:@int, "1", [1, 0]], :+, [:@int, "2", [1, 2]]]]
        assert_equal "1;\n1 + 2;\n", StmtsAddNode.new(sexp).make_code
      end
    end
  end
end
