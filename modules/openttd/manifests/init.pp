class openttd {
	
	exec { "install openttd":
		command => "wget -qO- http://binaries.openttd.org/releases/1.5.0/openttd-1.5.0-linux-generic-i686.tar.gz | gunzip | tar -xC /opt/",
		onlyif => "[ ! -d /opt/openttd-1.5.0-linux-generic-i686/ ]",
	}
	
	exec { "download openttd-opengfx":
		command => "wget -qO- http://binaries.openttd.org/extra/opengfx/0.5.2/opengfx-0.5.2-all.zip > /opt/opengfx.zip && unzip /opt/opengfx.zip && rm /opt/opengfx.zip",
		onlyif => "[ ! -d /opt/opengfx ]",
		require => Package["unzip"],
	}
	
	package { "unzip":
		ensure => present,
	}
	
	file { "/opt/openttd":
		ensure => link,
		target => "/opt/openttd-1.5.0-linux-generic-i686",
	}
	
	package { "tmux":
		ensure => present,
	}
	
	file { "/etc/rc.local":
		ensure => present,
		source => "puppet:///modules/openttd/rc.local",
	}
}
