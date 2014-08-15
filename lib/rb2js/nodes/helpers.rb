module Rb2js
  module Nodes
    module Helpers
       def wrap_with_parenthesis(code)
        return code if code[0] == '(' && code[-1] == ')'
        "(#{code})"
      end
    end
  end
end