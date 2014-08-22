require_relative '../../test_helper'

module Rb2coffee
  module Nodes
    class TestArgsAddNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_arguments
        # {fun}(3+4)
        sexp = [:args_add,
                [:args_new],
                [:paren,
                 [:stmts_add,
                  [:stmts_new],
                  [:binary, [:@int, "3", [5, 11]], :+, [:@int, "4", [5, 13]]]]]]
        assert_equal '(3 + 4)', ArgsAddNode.new(sexp).make_code
      end
    end
  end
end
