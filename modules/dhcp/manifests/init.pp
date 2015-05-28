class dhcp {
	package { "isc-dhcp-server":
		require => present,
	}
	
	
}
