class bind-server {
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
}