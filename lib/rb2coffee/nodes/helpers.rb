module Rb2coffee
  module Nodes
    module Helpers
      def wrap_with_parenthesis(code)
        return code if code[0] == '(' && code[-1] == ')'
        "(#{code})"
      end

      def find_hoistable_declarations_raw(sexp, res = [])
        return res.uniq if sexp.empty?
        if sexp[0] == :def || (sexp[0] == :var_field && sexp[1][0] == :@ident ) || sexp[0] == :class
          node = sexp[1][1].is_a?(Array) ? sexp[1][1][1] : sexp[1][1]
          return (res << node)
        end
        sexp[1..-1].compact.each do |child|
          if child.is_a?(Array)
            result = find_hoistable_declarations_raw(child,res)
            res + result if result
          end
        end
        return res.uniq
      end
    end
  end
end