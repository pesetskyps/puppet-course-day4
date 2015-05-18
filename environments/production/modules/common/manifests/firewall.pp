define common::firewall(){
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

  file { "c:/temp/test" :
    ensure  => directory,
    source_permissions => ignore,
  }

  net_share {'PuppetTest':
      ensure        => present,
      path          => 'c:\temp\test',
      require => File["c:/temp/test"]
  }

  #  acl { 'c:/temp/test':
  #  permissions                => [
  #   { identity => 'Everyone', rights => ['read'] }
  #  ],
  #  inherit_parent_permissions => 'true',
  #  require => File["c:/temp/test"]
  #}
  
}
