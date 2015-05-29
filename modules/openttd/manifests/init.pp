class openttd {
	package { "openttd":
		ensure => present,
	}
	
	package { "tmux":
		ensure => present,
	}
	
	file { "/etc/rc.local":
		ensure => present,
		source => "puppet:///modules/openttd/rc.local",
	}
}
