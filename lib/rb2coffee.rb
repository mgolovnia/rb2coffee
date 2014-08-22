$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'ripper'
require 'pp'
require 'rb2coffee/nodes/helpers'
require 'rb2coffee/nodes/node'
require 'rb2coffee/nodes/one_child_node'
require 'rb2coffee/nodes/arg_paren_node'
require 'rb2coffee/nodes/args_add_block_node'
require 'rb2coffee/nodes/args_add_node'
require 'rb2coffee/nodes/args_new_node'
require 'rb2coffee/nodes/assign_node'
require 'rb2coffee/nodes/begin_node'
require 'rb2coffee/nodes/binary_node'
require 'rb2coffee/nodes/block_var_node'
require 'rb2coffee/nodes/blockarg_node'
require 'rb2coffee/nodes/bodystmt_node'
require 'rb2coffee/nodes/brace_block_node'
require 'rb2coffee/nodes/call_node'
require 'rb2coffee/nodes/class_node'
require 'rb2coffee/nodes/const_node'
require 'rb2coffee/nodes/const_ref_node'
require 'rb2coffee/nodes/def_node'
require 'rb2coffee/nodes/do_block_node'
require 'rb2coffee/nodes/fcall_node'
require 'rb2coffee/nodes/i_var_node'
require 'rb2coffee/nodes/ident_node'
require 'rb2coffee/nodes/int_node'
require 'rb2coffee/nodes/method_add_arg_node'
require 'rb2coffee/nodes/method_add_block_node'
require 'rb2coffee/nodes/params_node'
require 'rb2coffee/nodes/paren_node'
require 'rb2coffee/nodes/program_node'
require 'rb2coffee/nodes/rest_param_node'
require 'rb2coffee/nodes/return_node'
require 'rb2coffee/nodes/stmts_add_node'
require 'rb2coffee/nodes/stmts_new_node'
require 'rb2coffee/nodes/var_field_node'
require 'rb2coffee/nodes/var_ref_node'
require 'rb2coffee/nodes/void_stmt_node'
require 'rb2coffee/nodes/yield0_node'
require 'rb2coffee/nodes/yield_node'

require 'rb2coffee/nodes/node_factory'

module Rb2coffee
  extend self

  def compile(source)
    sexp = Ripper.sexp_raw(source)
    Rb2coffee::Nodes::NodeFactory.make_node(sexp).make_code
  end
end
