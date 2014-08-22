require_relative '../../test_helper'

module Rb2coffee
  module Nodes
    class TestCallNode < MiniTest::Unit::TestCase

      def test_it_compiles_constructor_call
        sexp = [:call,
                 [:var_ref, [:@const, "C", [6, 6]]],
                 :".",
                 [:@ident, "new", [6, 8]]]
        assert_equal "new C", CallNode.new(sexp).make_code
      end

      def test_it_compiles_method_call
        sexp = [:call,
                [:var_ref, [:@ident, "c", [7, 2]]],
                :".",
                [:@ident, "to_s", [7, 4]]]
        assert_equal "c.to_s", CallNode.new(sexp).make_code
      end
    end
  end
end