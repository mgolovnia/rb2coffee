require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestConstNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_const_name
        # @x
        sexp = [:@const, "@x", [1, 0]]
        assert_equal 'x', ConstNode.new(sexp).make_code
      end
    end
  end
end
