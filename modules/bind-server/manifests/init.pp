class bind-server {
	$domain = hiera('domain')
	$hosts = hiera_hash('hosts')
	
	bind::view { "all":
		recursion	=> true,
		zones		=> ["$domain", "1.168.192.in-addr.arpa"],
	}
	
	bind::zone { $domain:
		zone_type		=> master,
		zone_contact	=> "hostmaster.$domain",
		zone_ns			=> ['ns1'],
		zone_ttl		=> 3600,
	}
	
	bind::zone { "1.168.192.in-addr.arpa":
		zone_type		=> master,
		zone_contact	=> "hostmaster.$domain",
		zone_ns			=> ["ns1.$domain."],
		zone_ttl		=> 3600,
	}
	
	define hieraHost {
		$hosts = hiera_hash('hosts')
		$ip = $hosts[$name]
		
		resource_record { "$name.bolklan.nl.":
			ensure => present,
			record => "$name.bolklan.nl",
			type => "A",
			data => $ip,
		}
	}
	
	$keys = keys($hosts)
	hieraHost { $keys: }
}