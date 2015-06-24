class ps_m4_examples::parameters(
	String[8] 
	$sitename="longlongname", # minimum value
	Variant[Boolean, Enum['true', 'false']]
	$notify_me =false,
	
	Pattern[/ps.*/]
	$foldername="ps_name",
  	Struct[{config => Enum['web.config', 'app.config']}]
    $myhashparam = {config => 'web.config'},
){
	if str2bool($notify_me) {
      notify{$sitename:}
    }

    notify{ $myhashparam[config] : }
}