require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestReturnNode < MiniTest::Unit::TestCase
      def test_it_compiles_return_with_parenthesis_into_return
        # return(3+4)
        sexp = [:return,
                [:args_add_block,
                 [:args_add,
                  [:args_new],
                  [:paren,
                   [:stmts_add,
                    [:stmts_new],
                    [:binary, [:@int, "3", [5, 11]], :+, [:@int, "4", [5, 13]]]]]],
                 false]]
        assert_equal "return(3 + 4)", ReturnNode.new(sexp).make_code
      end

      def test_it_compiles_return_without_parenthesis_into_return
        # return 3+4
        sexp = [:return,
                [:args_add_block,
                 [:args_add,
                  [:args_new],
                  [:binary, [:@int, "3", [3, 11]], :+, [:@int, "4", [3, 15]]]],
                 false]]
        assert_equal "return(3 + 4)", ReturnNode.new(sexp).make_code
      end
    end
  end
end