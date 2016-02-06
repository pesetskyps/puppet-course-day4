# Class: variables_invoker
#notify{"your variable is invisible: "}
#
class ps_m4_examples::variables_invoker(
	$show_dynamic_scope=false,
	$show_parent_level_scope=false,
	$show_node_level_scope=false,
	$show_global_scope=false,
) 
inherits ps_m4_examples::variables_parent
{
	#dynamic scoping. Deprecated
	if($show_dynamic_scope == true){
		include ps_m4_examples::variables_source
		notify{"your variable is visible via dynamic scope: $ps_m4_examples::variables_source::myvar":}	
	}

	#invisiable
	if($show_dynamic_scope == false){
		notify{"your variable is invisible: $ps_m4_examples::variables_source::myvar":}
	}

	#parent scoping
	if ($show_parent_level_scope == true) {
		notify{"your variable is parent scoped: $parent_var":}
	}
	
	#node level scoping
	if($show_node_level_scope == true){
		notify{"node level scope: $node_var":}
	}

	#global scope
	if($show_global_scope == true){
		notify{"global level scope: $global_var":}
	}

}
