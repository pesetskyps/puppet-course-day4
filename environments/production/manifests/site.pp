node 'dsccl1.hosting.ad.viacom.com' {
	notify {'hell':}
  common::firewall{'common':}
  include ps-web
  class {'ps-web::mysite':
    user => 'hosting\pesetskp',
    pass => 'Epam_2010',
  }
}
