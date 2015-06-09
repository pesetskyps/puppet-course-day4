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
  # 	sitename => "testlongname",
  # 	# notify_me => 'bla',
  # 	foldername => "ps_bla",
  # 	notify_me => 'true',
  # 	myhashparam => {config => "app.config",}
  # }  

  # #variable scoping
  # class {"ps_m4_examples::variables_invoker":
  #   show_dynamic_scope => true,
  #   show_parent_level_scope => true,
  #   show_node_level_scope => true,
  #   show_global_scope => true,
  # }
}



















node 'win-r3sga74n50h' {
  # include role::northwind::dev::webappdb

}
