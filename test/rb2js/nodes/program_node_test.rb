require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestProgramNode < MiniTest::Unit::TestCase
      def test_it_compiles_program_node
        # def foo(x)
        #   x * 2
        # end

        # x = 2
        # foo(x)
        sexp = [:program,
                 [:stmts_add,
                  [:stmts_add,
                   [:stmts_add,
                    [:stmts_new],
                    [:def,
                     [:@ident, "foo", [1, 6]],
                     [:paren, [:params, [[:@ident, "x", [1, 10]]], nil, nil, nil, nil]],
                     [:bodystmt,
                      [:stmts_add,
                       [:stmts_new],
                       [:binary,
                        [:var_ref, [:@ident, "x", [2, 4]]],
                        :*,
                        [:@int, "2", [2, 8]]]],
                      nil,
                      nil,
                      nil]]],
                   [:assign, [:var_field, [:@ident, "x", [5, 2]]], [:@int, "2", [5, 7]]]],
                  [:method_add_arg,
                   [:fcall, [:@ident, "foo", [6, 2]]],
                   [:arg_paren,
                    [:args_add_block,
                     [:args_add, [:args_new], [:var_ref, [:@ident, "x", [6, 6]]]],
                     false]]]]]
        assert_equal "var foo, x;\nfoo = function(x){\nreturn x * 2;\n};\nx = 2;\nfoo(x);\n", ProgramNode.new(sexp).make_code
      end

      def test_it_does_not_hoist_variable_declarations_from_functions
        # def foo(x)
        #   y = 2
        #   x * y
        # end

        # x = 2
        # foo(x)
        sexp = [:program,
                 [:stmts_add,
                  [:stmts_add,
                   [:stmts_add,
                    [:stmts_new],
                    [:def,
                     [:@ident, "foo", [1, 6]],
                     [:paren, [:params, [[:@ident, "x", [1, 10]]], nil, nil, nil, nil]],
                     [:bodystmt,
                      [:stmts_add,
                       [:stmts_add,
                        [:stmts_new],
                        [:assign, [:var_field, [:@ident, "y", [2, 4]]], [:@int, "2", [2, 8]]]],
                       [:binary,
                        [:var_ref, [:@ident, "x", [3, 4]]],
                        :*,
                        [:var_ref, [:@ident, "y", [3, 8]]]]],
                      nil,
                      nil,
                      nil]]],
                   [:assign, [:var_field, [:@ident, "x", [6, 2]]], [:@int, "2", [6, 7]]]],
                  [:method_add_arg,
                   [:fcall, [:@ident, "foo", [7, 2]]],
                   [:arg_paren,
                    [:args_add_block,
                     [:args_add, [:args_new], [:var_ref, [:@ident, "x", [7, 6]]]],
                     false]]]]]
          assert_equal "var foo, x;\nfoo = function(x){\nvar y;\ny = 2;\nreturn x * y;\n};\nx = 2;\nfoo(x);\n", ProgramNode.new(sexp).make_code
      end

    end
  end
end