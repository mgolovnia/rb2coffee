$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'ripper'
require 'pp'
require 'rb2js/nodes/helpers'
require 'rb2js/nodes/node'
require 'rb2js/nodes/one_child_node'
require 'rb2js/nodes/arg_paren_node'
require 'rb2js/nodes/args_add_block_node'
require 'rb2js/nodes/args_add_node'
require 'rb2js/nodes/args_new_node'
require 'rb2js/nodes/assign_node'
require 'rb2js/nodes/begin_node'
require 'rb2js/nodes/binary_node'
require 'rb2js/nodes/block_var_node'
require 'rb2js/nodes/blockarg_node'
require 'rb2js/nodes/bodystmt_node'
require 'rb2js/nodes/brace_block_node'
require 'rb2js/nodes/call_node'
require 'rb2js/nodes/class_node'
require 'rb2js/nodes/const_node'
require 'rb2js/nodes/const_ref_node'
require 'rb2js/nodes/def_node'
require 'rb2js/nodes/do_block_node'
require 'rb2js/nodes/fcall_node'
require 'rb2js/nodes/i_var_node'
require 'rb2js/nodes/ident_node'
require 'rb2js/nodes/int_node'
require 'rb2js/nodes/method_add_arg_node'
require 'rb2js/nodes/method_add_block_node'
require 'rb2js/nodes/params_node'
require 'rb2js/nodes/paren_node'
require 'rb2js/nodes/program_node'
require 'rb2js/nodes/rest_param_node'
require 'rb2js/nodes/return_node'
require 'rb2js/nodes/stmts_add_node'
require 'rb2js/nodes/stmts_new_node'
require 'rb2js/nodes/var_field_node'
require 'rb2js/nodes/var_ref_node'
require 'rb2js/nodes/void_stmt_node'
require 'rb2js/nodes/yield0_node'
require 'rb2js/nodes/yield_node'

require 'rb2js/nodes/node_factory'

module Rb2js
  extend self

  def compile(source)
    sexp = Ripper.sexp_raw(source)
    Rb2js::Nodes::NodeFactory.make_node(sexp).make_code
  end
end
