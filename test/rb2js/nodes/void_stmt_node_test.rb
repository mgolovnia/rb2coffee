require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestVoidStmtNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_empty_string
        # def foo(); end;
        sexp = [:void_stmt]
        assert_equal '', VoidStmtNode.new(sexp).make_code
      end
    end
  end
end
