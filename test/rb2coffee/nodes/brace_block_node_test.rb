require_relative '../../test_helper'

module Rb2coffee
  module Nodes
    class TestBraceBlockNode < MiniTest::Unit::TestCase
      def test_it_compiles_brace_block_and_return_last_computed_value
        # foo(1){|x| 1; 2; }
        sexp = [:brace_block,
                [:block_var,
                 [:params,
                  [[:@ident, "y", [1, 10]], [:@ident, "z", [1, 12]]],
                  nil,
                  nil,
                  nil,
                  nil],
                 nil],
                [:stmts_add,
                 [:stmts_add, [:stmts_new], [:@int, "1", [1, 15]]],
                 [:@int, "2", [1, 18]]]]
        assert_equal "function(){\nvar y = arguments[0];\nvar z = arguments[1];\n1;\nreturn 2;\n}", BraceBlockNode.new(sexp).make_code
      end

      def test_it_compiles_brace_block_with_explicit_return
        # foo(1){|x| 1; return(2); }
        sexp = [:brace_block,
                [:block_var,
                 [:params,
                  [[:@ident, "y", [1, 10]], [:@ident, "z", [1, 12]]],
                  nil,
                  nil,
                  nil,
                  nil],
                 nil],
                [:stmts_add,
                 [:stmts_add, [:stmts_new], [:@int, "1", [1, 15]]],
                 [:return,
                  [:args_add_block,
                   [:args_add,
                    [:args_new],
                    [:paren, [:stmts_add, [:stmts_new], [:@int, "2", [1, 25]]]]],
                   false]]]]
        assert_equal "function(){\nvar y = arguments[0];\nvar z = arguments[1];\n1;\nreturn (2);\n}", BraceBlockNode.new(sexp).make_code
      end
    end
  end
end
