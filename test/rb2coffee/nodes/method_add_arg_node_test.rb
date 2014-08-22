require_relative '../../test_helper'

module Rb2coffee
  module Nodes
    class TestMethodAddArgNode < MiniTest::Unit::TestCase
      def test_it_compiles_into_function_call
        # puts(1)
        sexp = [:method_add_arg,
                 [:fcall, [:@ident, "puts", [2, 2]]],
                 [:arg_paren,
                  [:args_add_block,
                   [:args_add, [:args_new], [:@int, "1", [1, 7]]],
                   false]]]
        assert_equal 'puts(1)', MethodAddArgNode.new(sexp).make_code
      end

      def test_it_compiles_into_function_call_with_function_calls_in_arguemtns
        # puts(2, list(1))
        sexp = [:method_add_arg,
                 [:fcall, [:@ident, "puts", [1, 2]]],
                 [:arg_paren,
                  [:args_add_block,
                   [:args_add,
                    [:args_add, [:args_new], [:@int, "2", [1, 7]]],
                    [:method_add_arg,
                     [:fcall, [:@ident, "list", [1, 10]]],
                     [:arg_paren,
                      [:args_add_block,
                       [:args_add, [:args_new], [:@int, "1", [1, 15]]],
                       false]]]
                    ]
                   ]
                  ]
                ]
         assert_equal 'puts(2, list(1))', MethodAddArgNode.new(sexp).make_code
      end
    end
  end
end
