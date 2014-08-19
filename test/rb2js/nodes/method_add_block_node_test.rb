require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestMethodAddBlockNode < MiniTest::Unit::TestCase
      def test_it_compiles_brace_block_into_function_call_with_anonymous_function_with_one_argument
        # foo(1){|x| 1 }
        sexp = [:method_add_block,
                 [:method_add_arg,
                  [:fcall, [:@ident, "foo", [1, 2]]],
                  [:arg_paren,
                   [:args_add_block,
                    [:args_add, [:args_new], [:@int, "1", [1, 6]]],
                    false]]],
                 [:brace_block,
                  [:block_var,
                   [:params, [[:@ident, "x", [1, 10]]], nil, nil, nil, nil],
                   nil],
                  [:stmts_add, [:stmts_new], [:@int, "1", [1, 13]]]]]
        assert_equal "foo._block = function(){\nvar x = arguments[0];\nreturn 1;\n};\nfoo(1)", MethodAddBlockNode.new(sexp).make_code
      end

      def test_it_compiles_brace_block_into_function_call_with_anonymous_function_with_multiple_arguments
        # foo(x){|y,z| 1 }
        sexp = [:method_add_block,
                 [:method_add_arg,
                  [:fcall, [:@ident, "foo", [1, 2]]],
                  [:arg_paren,
                   [:args_add_block,
                    [:args_add, [:args_new], [:@int, "1", [1, 6]]],
                    false]]],
                 [:brace_block,
                  [:block_var,
                   [:params,
                    [[:@ident, "y", [1, 10]], [:@ident, "z", [1, 12]]],
                    nil,
                    nil,
                    nil,
                    nil],
                   nil],
                  [:stmts_add, [:stmts_new], [:@int, "1", [1, 15]]]]]
        assert_equal "foo._block = function(){\nvar y = arguments[0];\nvar z = arguments[1];\nreturn 1;\n};\nfoo(1)", MethodAddBlockNode.new(sexp).make_code
      end

      def test_it_compiles_do_block_into_function_call_with_anonymous_function_with_one_argument
        # foo(1)do |x| 1 end;
        sexp = [:method_add_block,
                 [:method_add_arg,
                  [:fcall, [:@ident, "foo", [1, 2]]],
                  [:arg_paren,
                   [:args_add_block,
                    [:args_add, [:args_new], [:@int, "1", [1, 6]]],
                    false]]],
                 [:do_block,
                  [:block_var,
                   [:params, [[:@ident, "x", [1, 10]]], nil, nil, nil, nil],
                   nil],
                  [:stmts_add, [:stmts_new], [:@int, "1", [1, 13]]]]]
        assert_equal "foo._block = function(){\nvar x = arguments[0];\nreturn 1;\n};\nfoo(1)", MethodAddBlockNode.new(sexp).make_code
      end

      def test_it_compiles_do_block_into_function_call_with_anonymous_function_with_multiple_arguments
        # foo(x)do |y,z| 1 end;
        sexp = [:method_add_block,
                 [:method_add_arg,
                  [:fcall, [:@ident, "foo", [1, 2]]],
                  [:arg_paren,
                   [:args_add_block,
                    [:args_add, [:args_new], [:@int, "1", [1, 6]]],
                    false]]],
                 [:do_block,
                  [:block_var,
                   [:params,
                    [[:@ident, "y", [1, 10]], [:@ident, "z", [1, 12]]],
                    nil,
                    nil,
                    nil,
                    nil],
                   nil],
                  [:stmts_add, [:stmts_new], [:@int, "1", [1, 15]]]]]
        assert_equal "foo._block = function(){\nvar y = arguments[0];\nvar z = arguments[1];\nreturn 1;\n};\nfoo(1)", MethodAddBlockNode.new(sexp).make_code
      end
    end
  end
end
