require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestStmtsNewNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_empty_string
        sexp = [:stmts_new]
        assert_equal '', StmtsNewNode.new(sexp).make_code
      end
    end
  end
end
