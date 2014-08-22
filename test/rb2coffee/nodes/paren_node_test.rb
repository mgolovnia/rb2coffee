require_relative '../../test_helper'

module Rb2coffee
  module Nodes
    class TestParenNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_empty_function_params
        # ()
        sexp = [:paren, [:params, nil, nil, nil, nil, nil]]
        assert_equal '()', ParenNode.new(sexp).make_code
      end

      def test_it_compiles_into_function_params
        # (x,y)
        sexp = [:paren, [:params,[[:@ident, "x", [1, 8]], [:@ident, "y", [1, 10]]], nil, nil, nil, nil]]
        assert_equal '(x, y)', ParenNode.new(sexp).make_code
      end
    end
  end
end