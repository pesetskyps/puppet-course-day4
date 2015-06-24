class profile::dev::mysite{
	$sites = hiera_hash('iis_site::createsites')
	$site_defaults = hiera_hash('iis_site::defaults')
	create_resources('iis_site::createsite', $sites,$site_defaults)
}