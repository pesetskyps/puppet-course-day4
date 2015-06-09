# Class: ps_m4_examples::add_site() inherits 
#
#
class ps_m4_examples::add_site(
	String[8] 
	$sitename, # minimum value

	Variant[Boolean, Enum['true', 'false']]
	$notify_me =$ps_m4_examples::params::notify_me,
	
	Pattern[/ps.*/]
	$foldername=$ps_m4_examples::params::foldername,

  	Struct[{config => Enum['web.config', 'app.config']}]
    $myhashparam ={config => "web.config",},
    
) inherits ps_m4_examples::params {
	notify {"folder from add_site = $foldername":}
}