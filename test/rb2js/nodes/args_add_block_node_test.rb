require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestArgsAddBlockNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_arguments
        # return(3+4)
        sexp = [:args_add_block,
                 [:args_add,
                  [:args_new],
                  [:paren,
                   [:stmts_add,
                    [:stmts_new],
                    [:binary, [:@int, "3", [5, 11]], :+, [:@int, "4", [5, 13]]]]]],
                 false]
        assert_equal '(3 + 4)', ArgsAddBlockNode.new(sexp).make_code
      end
    end
  end
end
