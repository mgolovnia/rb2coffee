require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestBodystmtNode < MiniTest::Unit::TestCase
      def test_it_compiles_empty_body
        # def foo(); end;
        sexp = [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]
        assert_equal "{\nreturn;\n}", BodystmtNode.new(sexp).make_code
      end

      def test_it_computes_last_computed_value_of_bodystmt_with_one_statement
        sexp = [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]
        assert_equal '', BodystmtNode.new(sexp).last_computed_value.make_code
      end

      def test_it_computes_last_computed_value_of_bodystmt_with_multiple_statements
        sexp = [:bodystmt,
                [:stmts_add,
                 [:stmts_add,
                  [:stmts_add, [:stmts_new], [:void_stmt]],
                  [:binary, [:@int, "1", [1, 11]], :+, [:@int, "2", [1, 13]]]],
                 [:binary, [:@int, "1", [1, 16]], :+, [:@int, "4", [1, 18]]]], nil, nil, nil]
        assert_equal '1 + 4', BodystmtNode.new(sexp).last_computed_value.make_code
      end

      def test_it_returns_last_computed_value
        sexp = [:bodystmt,
                [:stmts_add,
                 [:stmts_add,
                  [:stmts_add, [:stmts_new], [:void_stmt]],
                  [:binary, [:@int, "1", [1, 11]], :+, [:@int, "2", [1, 13]]]],
                 [:binary, [:@int, "1", [1, 16]], :+, [:@int, "4", [1, 18]]]], nil, nil, nil]
        assert_equal "{\n1 + 2;\nreturn 1 + 4;\n}", BodystmtNode.new(sexp).make_code
      end

      def test_it_creates_variables_declarations
        # {
        #  x = 1
        #  y = 2
        # }
        sexp = [:bodystmt,
                [:stmts_add,
                 [:stmts_add,
                  [:stmts_new],
                  [:assign, [:var_field, [:@ident, "x", [2, 4]]], [:@int, "1", [2, 9]]]],
                 [:assign, [:var_field, [:@ident, "y", [3, 4]]], [:@int, "2", [3, 9]]]],
                nil,
                nil,
                nil]
        assert_equal "{\n" \
                     "var x, y;\n" \
                     "x = 1;\n" \
                     "return y = 2;\n" \
                     "}", BodystmtNode.new(sexp).make_code
      end

      def test_it_hoists_function_declarations
        # {
        #  x = 1
        #  def bar;
        #  end
        # }
        sexp = [:bodystmt,
                [:stmts_add,
                 [:stmts_add,
                  [:stmts_new],
                  [:assign, [:var_field, [:@ident, "x", [2, 4]]], [:@int, "1", [2, 9]]]],
                 [:def,
                  [:@ident, "bar", [3, 8]],
                  [:params, nil, nil, nil, nil, nil],
                  [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]]],
                nil,
                nil,
                nil]
        assert_equal "{\n" \
                     "var x, bar;\n" \
                     "x = 1;\n" \
                     "bar = function(){\nreturn;\n};\n"\
                     "return bar;\n}", BodystmtNode.new(sexp).make_code
      end
    end
  end
end
