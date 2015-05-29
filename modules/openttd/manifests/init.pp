class openttd {
	
	exec { "install openttd":
		command => "wget -qO- http://binaries.openttd.org/releases/1.5.0/openttd-1.5.0-linux-generic-i686.tar.gz | gunzip | tar -xC /opt/",
		onlyif => "[ -d /opt/openttd/ ]",
	}
	
	package { "tmux":
		ensure => present,
	}
	
	file { "/etc/rc.local":
		ensure => present,
		source => "puppet:///modules/openttd/rc.local",
	}
}
