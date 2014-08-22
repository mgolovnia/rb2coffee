require_relative '../../test_helper'

module Rb2coffee
  module Nodes
    class TestOneChildNode < MiniTest::Unit::TestCase
      def test_it_makes_childs_code
        assert_equal "1", OneChildNode.new([:program, [:stmts_add, [:stmts_new], [:@int, "1"]]]).make_code
      end
    end
  end
end