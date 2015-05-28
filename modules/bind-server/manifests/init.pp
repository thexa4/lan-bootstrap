class bind-server( $cache = false, $cache_ip = "") {
	
	$domain = hiera('domain')
	$hosts = hiera_hash('hosts')
	
	bind::zone { $domain:
		zone_contact	=> "hostmaster.$domain",
		zone_ns			=> ['ns1'],
		zone_serial		=> 42,
		zone_ttl		=> 3600,
		zone_origin		=> $domain,
	}
	
	bind::zone { "1.168.192.in-addr.arpa":
		zone_contact	=> "hostmaster.$domain",
		zone_ns			=> ['ns1'],
		zone_serial		=> 42,
		zone_ttl		=> 3600,
		zone_origin		=> "1.168.192.in-addr.arpa",
	}
	
	define cacheZone( $ensure = "present" ) {
		$ip = hiera("bind-server::cache_ip")
	
		bind::zone { "$name":
			ensure			=> $ensure,
			zone_contact	=> "hostmaster.$domain",
			zone_ns			=> ['ns1'],
			zone_serial		=> 42,
			zone_ttl		=> 3600,
			zone_origin		=> "$name",
		}
		
		bind::a { "$name.":
			ensure 		=> $ensure,
			zone 		=> "$name",
			hash_data	=> {
				"" => { owner => $ip },
			},
		}
		
		bind::a { "*.$name.":
			ensure 		=> $ensure,
			zone 		=> "$name",
			ptr 		=> false,
			hash_data	=> {
				"*" => { owner => $ip },
			},
			require => Bind::A["$name."],
		}
	}
	
	define hieraHost {
		$hosts = hiera_hash('hosts')
		$ip = $hosts[$name]
		$domain = hiera('domain')
		
		bind::a { "$name.$domain.":
			ensure => present,
			zone => $domain,
			ptr	=> true,
			zone_arpa => "1.168.192.in-addr.arpa",
			hash_data => {
				"$name" => { owner => $ip, },
			},
		}
	}
	
	file_line { '/etc/bind/named.conf.options recursion':
		path => '/etc/bind/named.conf.options',
		line => '	allow-recursion { 192.168.1.0/24; };',
		after => 'options {',
		require => Bind::Zone[$domain],
		notify => Service['bind9'],
	}
	
	file_line { '/etc/bind/named.conf.options forwarders':
		path => '/etc/bind/named.conf.options',
		line => '	forwarders { 8.8.8.8; 8.8.4.4; };',
		after => 'options {',
		require => Bind::Zone[$domain],
		notify => Service['bind9'],
	}
	
	$keys = keys($hosts)
	hieraHost { $keys: }
	
		$overrides = [
			"cs.steampowered.com",
			"content1.steampowered.com",
			"content2.steampowered.com",
			"content3.steampowered.com",
			"content4.steampowered.com",
			"content5.steampowered.com",
			"content6.steampowered.com",
			"content7.steampowered.com",
			"content8.steampowered.com",
		]
		
		cacheZone { $overrides:
			ensure => $cache ? "present" : "absent",
		}
}