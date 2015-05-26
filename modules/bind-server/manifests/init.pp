class bind-server {
	Exec {
		path => '/bin;/sbin;/usr/bin;/usr/sbin',
	}

	$domain = hiera('domain')
	$hosts = hiera_hash('hosts')
	
	bind::zone { "1.168.192.in-addr.arpa":
		zone_contact	=> "hostmaster.$domain",
		zone_ns			=> ['ns1'],
		zone_serial		=> 42,
		zone_ttl		=> 3600,
		zone_origin		=> "1.168.192.in-addr.arpa",
	}
	
	define hieraHost {
		$hosts = hiera_hash('hosts')
		$ip = $hosts[$name]
		$domain = hiera('domain')
		
		bind::a { "$name.bolklan.nl.":
			ensure => present,
			zone => $domain,
			ptr	=> true,
			data => { owner => $ip, },
		}
	}
	
	$keys = keys($hosts)
	hieraHost { $keys: }
}