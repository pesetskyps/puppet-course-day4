class nxlog($system) {
  $nxlog_package_name = 'nxlog-ce-2.8.1248.msi'
  $nxlog_config = "c:\\Program Files (x86)\\nxlog\\conf\\nxlog.conf"
  $nxlog_local_path = "c:\\temp\\${nxlog_package_name}"
  $nxlog_puppet_path = "puppet:///modules/nxlog/${nxlog_package_name}"

case $system
  {
    'web-app-db' : {$nxlogtemplate_puppet_path='nxlog/nxlog.conf.erb'}
    default : {
      notify {"System is not specified. Please verify it is set to 'cus','daapi','www tracking widgets3','fluxstatic cdn wdk4 activity_widgets4_static','activity','moderation','ugc','rtx','captcha','rtxsupport act_service','sql','jmeter'":loglevel => err,}
    }
  }

  #Copy source files
  file { $nxlog_local_path:
    ensure             => 'present',
    source             => $nxlog_puppet_path,
    source_permissions => ignore,
  }
  #install
  package { 'NXLOG-CE':
    ensure          => '2.8.1248',
    source          => $nxlog_local_path,
    require         => File[$nxlog_local_path],
    install_options => ['/q'],
  }

  # Edit config
  file { $nxlog_config:
    path               => $nxlog_config,
    ensure             => file,
    require            => Package['NXLOG-CE'],
    source_permissions => ignore,
    content            => template($nxlogtemplate_puppet_path),
  }
  #Insure status of the service
  service { 'nxlog':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['NXLOG-CE'],
    subscribe  => File[$nxlog_config],
  }
}
