class bind-server {
	$domain = hiera('domain')
	$hosts = hiera_hash('hosts')
	
	bind::zone { $domain:
		zone_contact	=> "hostmaster.$domain",
		zone_ns			=> ['ns1'],
		zone_serial		=> 1,
		zone_ttl		=> 3600,
		zone_origin		=> $domain,
	}
	
	
}