require_relative '../../test_helper'

module Rb2coffee
  module Nodes
    class TestIdentNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_identifier
        # foo
        sexp = [:@ident, "foo", [1, 4]]
        assert_equal 'foo', IdentNode.new(sexp).make_code
      end
    end
  end
end