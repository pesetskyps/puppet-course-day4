$powershell = 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -ExecutionPolicy RemoteSigned -noprofile -nologo -noninteractive -command'
$global_var = 'globalvar'

node default {
  $node_var = "node_var"
  # #parameters
  # class {"ps_m4_examples::parameters":
  # 	sitename => "testlongname",
  # 	# notify_me => 'bla',
  # 	foldername => "ps_bla",
  # 	notify_me => 'true',
  # 	myhashparam => {config => "app.config",}
  # }

  # #params principle
  # class {"ps_m4_examples::add_site":
  # 	sitename => "yaaaahooooo",
  # }

  # #variable scoping
  # class {"ps_m4_examples::variables_invoker":
  #   show_dynamic_scope => true,
  #   show_parent_level_scope => true,
  #   show_node_level_scope => true,
  #   show_global_scope => true,
  # }

  # require class
  # include ps_m4_examples::require_example

  # resource defaults
  # include ps_m4_examples::resource_defaults_ex

  # stdlib functions
  # include ps_m4_examples::stdlib_ex
  
  #bad practicies
  # if defined
  # include ps_m4_examples::bad_practicies_2
  # include ps_m4_examples::bad_practicies
    
  # #roles and profiles
  # include role::web
}

# node 'win-r3sga74n50h' {
#  include role::northwind::dev::webappdb
#   # include role::web
# # notify{"bla":}
# }