class samba {
	package { "samba":
		ensure => present,
	}
	
	service { "samba":
		ensure => running,
		require => Package["samba"],
	}
	
	file { "/etc/samba/smb.conf":
		ensure => present,
		source => "puppet:///modules/samba/smb.conf",
		require => Package["samba"],
		notify => Service["samba"],
	}

	file { "/data":
		ensure => directory,
	}

	file { "/data/games":
		ensure => directory,
		require => File["/data"],
	}
}
