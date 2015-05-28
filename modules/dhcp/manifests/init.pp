class dhcp {
	package { "isc-dhcp-server":
		ensure => present,
	}
	
	service { "isc-dhcp-server":
		ensure => running,
		require => Package["isc-dhcp-server"],
	}
	
	file { "/etc/dhcp/dhcpd.conf":
		ensure => present,
		source => "puppet:///modules/dhcp/dhcpd.conf",
		require => Package["isc-dhcp-server"],
		notify => Service["isc-dhcp-server"],
	}
	
	file { "/etc/defaults/isc-dhcp-server":
		ensure => present,
		source => "puppet:///modules/dhcp/isc-dhcp-server",
		require => Package["isc-dhcp-server"],
		notify => Service["isc-dhcp-server"],
	}
}
