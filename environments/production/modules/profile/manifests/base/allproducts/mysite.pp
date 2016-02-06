class profile::base::allproducts::mysite{
	$sites = hiera_hash('iis_site::createsites')
	$site_defaults = hiera_hash('iis_site::defaults')
	create_resources('iis_site::createsite', $sites,$site_defaults)

	$site_deploy = hiera_hash('iis_site::deploy')
	create_resources('iis_site::deploy', $site_deploy)
}