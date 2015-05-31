class ps_sql::firewall{
	windows_firewall::exception { 'Allow sql 1433 port':
	  ensure       => present,
	  direction    => 'in',
	  action       => 'Allow',
	  enabled      => 'yes',
	  protocol     => 'TCP',
	  local_port   => '1433',
	  display_name => 'Allow MSSQL TCP connection port',
	  description  => 'Allow MSSQL TCP connection port',
	  require => Class['mssql']
	}
}