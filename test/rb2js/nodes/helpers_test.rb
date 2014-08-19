require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestHelpers < MiniTest::Unit::TestCase
      include Helpers

      def test_it_wraps_code_with_parenthesis
        assert_equal '(code)', wrap_with_parenthesis('code')
      end

      def test_it_doesnt_add_additional_parenthesis
        assert_equal '(code)', wrap_with_parenthesis('(code)')
      end

      def test_it_finds_hoistable_declarations
        sexp = [:bodystmt,
                [:stmts_add,
                 [:stmts_add,
                  [:stmts_new],
                  [:assign, [:var_field, [:@ident, "x", [2, 4]]], [:@int, "1", [2, 9]]]],
                 [:def,
                  [:@ident, "bar", [3, 8]],
                  [:params, nil, nil, nil, nil, nil],
                  [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]]],
                nil,
                nil,
                nil]

        assert_equal ['x', 'bar'], find_hoistable_declarations_raw(sexp)
      end
    end
  end
end
