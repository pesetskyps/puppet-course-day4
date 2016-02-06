# Class: class profile::dev::base
#
#
class profile::base::allproducts::base {
	windows_firewall::exception { 'Allow Zabbix Agent port':
	  ensure       => present,
	  direction    => 'in',
	  action       => 'Allow',
	  enabled      => 'yes',
	  protocol     => 'TCP',
	  local_port   => '10050',
	  display_name => 'Allow Zabbix Agent port',
	  description  => 'Inbound rule for Zabbix Agent port',
	}
}