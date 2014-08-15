require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestClassNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_emtpy_class
        # class C
        # end
        sexp = [:class,
                 [:const_ref, [:@const, "C", [1, 8]]],
                 nil,
                 [:bodystmt, [:stmts_add, [:stmts_new], [:void_stmt]], nil, nil, nil]]
        assert_equal "C = (function(){\n" \
                     "function C(){};\n" \
                      "return(C);\n" \
                     "})()", ClassNode.new(sexp).make_code
      end

      def test_it_compiles_constructor
        # class C
        #   def initiazlize
        #     @x = 1
        #   end
        # end
        sexp = [:class,
                 [:const_ref, [:@const, "C", [1, 8]]],
                 nil,
                 [:bodystmt,
                  [:stmts_add,
                   [:stmts_new],
                   [:def,
                    [:@ident, "initialize", [2, 8]],
                    [:params, nil, nil, nil, nil, nil],
                    [:bodystmt,
                     [:stmts_add,
                      [:stmts_new],
                      [:assign,
                       [:var_field, [:@ivar, "@x", [3, 6]]],
                       [:@int, "1", [3, 11]]]],
                     nil,
                     nil,
                     nil]]],
                  nil,
                  nil,
                  nil]]
        assert_equal "C = (function(){\n" \
                      "function C(){\n" \
                      "this.x = 1;\n"\
                      "};\n" \
                      "return(C);\n" \
                     "})()", ClassNode.new(sexp).make_code
      end

      def test_it_compiles_instance_methods
        # class C
        #   def initiazlize(value)
        #     @x = value
        #   end
        #   def foo
        #     @x * 2
        #   end
        # end
        sexp = [:class,
                 [:const_ref, [:@const, "C", [1, 8]]],
                 nil,
                 [:bodystmt,
                  [:stmts_add,
                   [:stmts_add,
                    [:stmts_new],
                    [:def,
                     [:@ident, "initialize", [2, 8]],
                     [:paren, [:params, [[:@ident, "value", [2, 19]]], nil, nil, nil, nil]],
                     [:bodystmt,
                      [:stmts_add,
                       [:stmts_new],
                       [:assign,
                        [:var_field, [:@ivar, "@x", [3, 6]]],
                        [:var_ref, [:@ident, "value", [3, 11]]]]],
                      nil,
                      nil,
                      nil]]],
                   [:def,
                    [:@ident, "foo", [5, 8]],
                    [:params, nil, nil, nil, nil, nil],
                    [:bodystmt,
                     [:stmts_add,
                      [:stmts_new],
                      [:binary,
                       [:var_ref, [:@ivar, "@x", [6, 6]]],
                       :*,
                       [:@int, "2", [6, 11]]]],
                     nil,
                     nil,
                     nil]]],
                  nil,
                  nil,
                  nil]]
        assert_equal "C = (function(){\n" \
                      "function C(value){\n" \
                      "this.x = value;\n"\
                      "};\n" \
                      "C.prototype.foo = function(){\n" \
                      "return(this.x * 2);\n" \
                      "};\n" \
                      "return(C);\n" \
                     "})()", ClassNode.new(sexp).make_code
      end
    end
  end
end
