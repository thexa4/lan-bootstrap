class openttd {
	
	exec { "install openttd":
		command => "wget -qO- http://binaries.openttd.org/releases/1.5.0/openttd-1.5.0-linux-generic-i686.tar.gz | gunzip | tar -xC /opt/",
		onlyif => "[ ! -d /opt/openttd-1.5.0-linux-generic-i686/ ]",
	}
	
	exec { "download openttd-opengfx":
		command => "cd /root/.openttd/basegame && wget -qO- http://binaries.openttd.org/extra/opengfx/0.5.2/opengfx-0.5.2-all.zip > /tmp/opengfx.zip && unzip /tmp/opengfx.zip && rm /tmp/opengfx.zip",
		onlyif => "[ ! -f /root/.openttd/basegame/opengfx-0.5.2.tar ]",
		require => [ Package["unzip"], File["/root/.openttd/basegame"] ],
	}
	
	package { "unzip":
		ensure => present,
	}
	
	file { "/opt/openttd":
		ensure => link,
		target => "/opt/openttd-1.5.0-linux-generic-i686",
	}
	
	file { "/root/.openttd":
		ensure => directory,
	}
	
	file { "/root/.openttd/basegame":
		ensure => directory,
		require => File["/root/.openttd/basegame"],	
	}
		
	package { "tmux":
		ensure => present,
	}
	
	file { "/etc/rc.local":
		ensure => present,
		source => "puppet:///modules/openttd/rc.local",
	}
}
