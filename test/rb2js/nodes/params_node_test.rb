require_relative '../../test_helper'

module Rb2js
  module Nodes
    class TestParamsNode < MiniTest::Unit::TestCase
      def test_it_adds_explicit_block_argument
        # (x,y,z)
        sexp = [:params,
                 [[:@ident, "x", [1, 8]],
                  [:@ident, "y", [1, 10]],
                  [:@ident, "z", [1, 12]]],
                 nil,
                 nil,
                 nil,
                 nil]
        assert_equal ['x', 'y', 'z'], ParamsNode.new(sexp).params_names
      end

      def test_it_supports_block_argument
        # (x,y,z, &block)
        sexp = [:params,
                 [[:@ident, "x", [1, 8]],
                  [:@ident, "y", [1, 10]],
                  [:@ident, "z", [1, 12]]],
                 nil,
                 nil,
                 nil,
                [:blockarg, [:@ident, "block", [1, 28]]]]
        assert_equal ['x', 'y', 'z'], ParamsNode.new(sexp).params_names
      end

      def test_it_compiles_array_of_uninitialized_params
        # (x,y,z)
        sexp = [:params,
                 [[:@ident, "x", [1, 8]],
                  [:@ident, "y", [1, 10]],
                  [:@ident, "z", [1, 12]]],
                 nil,
                 nil,
                 nil,
                 nil]
        assert_equal 'x, y, z', ParamsNode.new(sexp).make_code
      end

       def test_it_compiles_empty_array_of_params
        # ()
        sexp = [:params,
                 nil,
                 nil,
                 nil,
                 nil,
                 nil]
        assert_equal '', ParamsNode.new(sexp).make_code
      end

      def test_it_compiles_empty_array_of_initialized_params
        # (x = 2)
        sexp = [:params,
                 nil,
                 [[[:@ident, "x", [1, 13]], [:@int, "2", [1, 17]]]],
                 nil,
                 nil,
                 nil]
        assert_equal 'x', ParamsNode.new(sexp).make_code
      end

      def test_it_compiles_empty_array_of_mixed_params
        # (bar, x=1, k=2, y, z)
        sexp = [:params,
                 [[:@ident, "bar", [1, 10]]],
                 [[[:@ident, "x", [1, 15]], [:@int, "1", [1, 18]]],
                  [[:@ident, "k", [1, 21]], [:@int, "2", [1, 23]]]],
                 nil,
                 [[:@ident, "y", [1, 26]], [:@ident, "z", [1, 29]]],
                 nil]
        assert_equal 'bar, y, z, x, k', ParamsNode.new(sexp).make_code
      end

      def test_it_returns_true_if_params_have_rest_params
        # (x,y, *args)
        sexp = [:params,
                 [[:@ident, "x", [1, 10]], [:@ident, "y", [1, 12]]],
                 nil,
                 [:rest_param, [:@ident, "args", [1, 15]]],
                 nil,
                 nil]
        assert ParamsNode.new(sexp).rest_param?
      end

      def test_it_returns_false_if_params_dont_have_rest_params
        # (x,y, *args)
        sexp = [:params,
                 [[:@ident, "x", [1, 10]], [:@ident, "y", [1, 12]]],
                 nil,
                 nil,
                 nil,
                 nil]
        refute ParamsNode.new(sexp).rest_param?
      end

      def test_it_returns_empty_string_if_params_have_rest_params
        # (x,y, *args)
        sexp = [:params,
                 [[:@ident, "x", [1, 10]], [:@ident, "y", [1, 12]]],
                 nil,
                 [:rest_param, [:@ident, "args", [1, 15]]],
                 nil,
                 nil]
        assert_equal '', ParamsNode.new(sexp).make_code
      end

      def test_it_returns_array_of_params_names
        # (x,y, *args)
        # (bar, x=1, k=2, y, z)
        sexp = [:params,
                 [[:@ident, "bar", [1, 10]]],
                 [[[:@ident, "x", [1, 15]], [:@int, "1", [1, 18]]],
                  [[:@ident, "k", [1, 21]], [:@int, "2", [1, 23]]]],
                 [:rest_param, [:@ident, "args", [1, 15]]],
                 [[:@ident, "y", [1, 26]], [:@ident, "z", [1, 29]]],
                 nil]
        assert_equal ['bar', 'y', 'z', 'x', 'k', 'args'], ParamsNode.new(sexp).params_names
      end
    end
  end
end