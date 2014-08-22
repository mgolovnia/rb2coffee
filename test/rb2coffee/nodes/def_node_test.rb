require_relative '../../test_helper'

module Rb2coffee
  module Nodes
    class TestDefNode < MiniTest::Unit::TestCase

      def test_it_compiles_from_function_without_params_into_empty_function
        # def foo
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 4]],
                 [:params, nil, nil, nil, nil, nil],
                 [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]]
        assert_equal "foo = function(){\nreturn;\n}", DefNode.new(sexp).make_code
      end

      def test_it_compiles_from_function_without_params
        # def foo()
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 4]],
                 [:paren, [:params, nil, nil, nil, nil, nil]],
                 [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]]
        assert_equal "foo = function(){\nreturn;\n}", DefNode.new(sexp).make_code
      end

      def test_it_compiles_from_function_with_params
        # def foo(x, y)
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 4]],
                 [:paren, [:params, [[:@ident, "x", [1, 8]], [:@ident, "y", [1, 10]]], nil, nil, nil, nil]],
                 [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]]
        assert_equal "foo = function(x, y){\nreturn;\n}", DefNode.new(sexp).make_code
      end

      def test_it_compiles_into_function_that_returns_result_of_last_computation
        # def foo
        #   1 + 2
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 4]],
                 [:params, nil, nil, nil, nil, nil],
                 [:bodystmt,
                  [:stmts_add,
                   [:stmts_new],
                   [:binary, [:@int, "1", [2, 0]], :+, [:@int, "2", [2, 2]]]],nil,nil,nil]]
        assert_equal "foo = function(){\nreturn 1 + 2;\n}", DefNode.new(sexp).make_code
      end

      def test_it_compiles_from_function_with_multiplle_istructions_into_function_that_returns_result_of_last_computation
        # def foo
        #   3 + 4
        #   1 + 2
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 4]],
                 [:params, nil, nil, nil, nil, nil],
                 [:bodystmt,
                  [:stmts_add,
                   [:stmts_add,
                    [:stmts_new],
                    [:binary, [:@int, "3", [1, 8]], :+, [:@int, "4", [1, 10]]]],
                   [:binary, [:@int, "1", [1, 12]], :+, [:@int, "2", [1, 14]]]],
                  nil,
                  nil,
                  nil]]
        assert_equal "foo = function(){\n3 + 4;\nreturn 1 + 2;\n}", DefNode.new(sexp).make_code
      end

      def test_it_compiles_function_with_explicit_return
        # def foo
        #   3 + 4
        #   return(1)
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 6]],
                 [:params, nil, nil, nil, nil, nil],
                 [:bodystmt,
                  [:stmts_add,
                   [:stmts_add,
                    [:stmts_new],
                    [:binary, [:@int, "3", [2, 4]], :+, [:@int, "4", [2, 6]]]],
                   [:return,
                    [:args_add_block,
                     [:args_add,
                      [:args_new],
                      [:paren, [:stmts_add, [:stmts_new], [:@int, "1", [3, 11]]]]],
                     false]]],
                  nil,
                  nil,
                  nil]]
        assert_equal "foo = function(){\n3 + 4;\nreturn (1);\n}", DefNode.new(sexp).make_code
      end

      def test_it_compiles_function_with_multiple_explicit_returns
        # def foo
        #   return(2)
        #   3 + 4
        #   return(1)
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 6]],
                 [:params, nil, nil, nil, nil, nil],
                 [:bodystmt,
                  [:stmts_add,
                   [:stmts_add,
                    [:stmts_add,
                     [:stmts_new],
                     [:return,
                      [:args_add_block,
                       [:args_add,
                        [:args_new],
                        [:paren, [:stmts_add, [:stmts_new], [:@int, "2", [2, 11]]]]],
                       false]]],
                    [:binary, [:@int, "3", [3, 4]], :+, [:@int, "4", [3, 6]]]],
                   [:return,
                    [:args_add_block,
                     [:args_add,
                      [:args_new],
                      [:paren, [:stmts_add, [:stmts_new], [:@int, "1", [4, 11]]]]],
                     false]]],
                  nil,
                  nil,
                  nil]]
        assert_equal "foo = function(){\nreturn (2);\n3 + 4;\nreturn (1);\n}", DefNode.new(sexp).make_code
      end

      def test_it_compiles_function_with_optional_arguments
        # def foo(*args)
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 6]],
                 [:params, nil, nil, [:rest_param, [:@ident, "args", [1, 11]]], nil, nil],
                 [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]]
        assert_equal "foo = function(){\nvar args;\nargs = 1 <= arguments.length ? Array.prototype.slice.call(arguments, 0) : [];\nreturn;\n}", DefNode.new(sexp).make_code
      end

      def test_it_compiles_function_with_required_and_optional_arguments
        # def foo(x, *args)
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 6]],
                 [:paren,
                  [:params,
                   [[:@ident, "x", [1, 10]]],
                   nil,
                   [:rest_param, [:@ident, "args", [1, 14]]],
                   nil,
                   nil]],
                 [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]]
        assert_equal "foo = function(){\nvar x, args;\nx = arguments[0];\nargs = 2 <= arguments.length ? Array.prototype.slice.call(arguments, 1) : [];\nreturn;\n}", DefNode.new(sexp).make_code
      end

      def test_it_compiles_function_with_required_optional_and_arguments_with_default_values
        # def foo(x, y = 1,*args)
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 6]],
                 [:paren,
                  [:params,
                   [[:@ident, "x", [1, 10]]],
                   [[[:@ident, "y", [1, 13]], [:@int, "1", [1, 17]]]],
                   [:rest_param, [:@ident, "args", [1, 21]]],
                   nil,
                   nil]],
                 [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]]
         code = "foo = function(){\n" \
                  "var x, y, args;\n" \
                  "x = arguments[0];\n" \
                  "y = arguments[1];\n" \
                  "args = 3 <= arguments.length ? Array.prototype.slice.call(arguments, 2) : [];\n" \
                  "y = typeof y !== 'undefined' ? y : 1;\n" \
                  "return;\n" \
                "}"
        assert_equal code, DefNode.new(sexp).make_code
      end

      def test_it_compiles_functions_with_yield_and_explicit_block_argument
        # def foo(*args, &block)
        #   yield
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 6]],
                 [:paren,
                  [:params,
                   nil,
                   nil,
                   [:rest_param, [:@ident, "args", [1, 11]]],
                   nil,
                   [:blockarg, [:@ident, "block", [1, 18]]]]],
                 [:bodystmt, [:stmts_add, [:stmts_new], [:yield0]], nil, nil, nil]]
        code = "foo = function(){\n" \
                  "var args;\n" \
                  "args = 1 <= arguments.length ? Array.prototype.slice.call(arguments, 0) : [];\n" \
                  "return foo._block();\n" \
                "}"
        assert_equal code, DefNode.new(sexp).make_code
      end

      def test_it_compiles_functions_with_yield_and_implicit_block_argument
        # def foo()
        #   yield
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 6]],
                 [:paren,
                  [:params,
                   nil,
                   nil,
                   [:rest_param, [:@ident, "args", [1, 11]]],
                   nil,
                   nil]],
                 [:bodystmt, [:stmts_add, [:stmts_new], [:yield0]], nil, nil, nil]]
        code = "foo = function(){\n" \
                  "var args;\n" \
                  "args = 1 <= arguments.length ? Array.prototype.slice.call(arguments, 0) : [];\n" \
                  "return foo._block();\n" \
                "}"
        assert_equal code, DefNode.new(sexp).make_code
      end

      def test_it_compiles_functions_with_yield_with_params
        # def foo()
        #   yield(1,2,3)
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 6]],
                 [:paren,
                  [:params, nil, nil, nil, nil, [:blockarg, [:@ident, "blk", [1, 11]]]]],
                 [:bodystmt,
                  [:stmts_add,
                   [:stmts_new],
                   [:yield,
                    [:paren,
                     [:args_add_block,
                      [:args_add,
                       [:args_add,
                        [:args_add, [:args_new], [:@int, "1", [2, 10]]],
                        [:@int, "2", [2, 12]]],
                       [:@int, "3", [2, 14]]],
                      false]]]],
                  nil,
                  nil,
                  nil]]
        code = "foo = function(){\n" \
                  "return foo._block(1, 2, 3);\n" \
                "}"
        assert_equal code, DefNode.new(sexp).make_code
      end


      def test_it_compiles_functions_with_yield_in_expression
        # def foo(*args)
        #   y = yield
        #   return y
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 6]],
                 [:paren,
                  [:params,
                   nil,
                   nil,
                   [:rest_param, [:@ident, "args", [1, 11]]],
                   nil,
                   nil]],
                 [:bodystmt,
                  [:stmts_add,
                   [:stmts_add,
                    [:stmts_new],
                    [:assign, [:var_field, [:@ident, "y", [2, 4]]], [:yield0]]],
                   [:return,
                    [:args_add_block,
                     [:args_add, [:args_new], [:var_ref, [:@ident, "y", [3, 11]]]],
                     false]]],
                  nil,
                  nil,
                  nil]]
        code = "foo = function(){\n" \
                  "var args;\n" \
                  "args = 1 <= arguments.length ? Array.prototype.slice.call(arguments, 0) : [];\n" \
                  "var y;\n" \
                  "y = foo._block();\n"\
                  "return y;\n" \
                "}"
        assert_equal code, DefNode.new(sexp).make_code
      end

      def test_it_renames_block_argument
        # def foo(&blk)
        #   blk
        # end
        sexp = [:def,
                 [:@ident, "foo", [1, 6]],
                 [:paren,
                  [:params, nil, nil, nil, nil, [:blockarg, [:@ident, "blk", [1, 11]]]]],
                 [:bodystmt,
                  [:stmts_add, [:stmts_new], [:var_ref, [:@ident, "blk", [2, 4]]]],
                  nil,
                  nil,
                  nil]]
        code = "foo = function(){\n" \
                  "return foo._block;\n" \
                "}"
        assert_equal code, DefNode.new(sexp).make_code
      end
    end
  end
end