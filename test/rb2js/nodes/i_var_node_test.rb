require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestIVarNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_var_name
        # @x
        sexp = [:@ivar, "@x", [1, 0]]
        assert_equal 'this.x', IVarNode.new(sexp).make_code
      end
    end
  end
end
