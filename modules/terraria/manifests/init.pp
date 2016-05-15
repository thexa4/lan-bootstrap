class terraria {

	package {"mono-complete":
		ensure => present,
	}
	
	package { "unzip":
		ensure => present,
	}

	exec { "download terraria":
		command => "wget -qO- https://github.com/NyxStudios/TShock/releases/download/v4.3.12/tshock_4.3.12.zip > /tmp/tshock.zip && unzip /tmp/tshock.zip -d /opt/terraria && rm /tmp/tshock.zip",
		unless => "[ -d /opt/terraria ]",
		require => [ Package["unzip"] ],
	}

	package { "tmux":
		ensure => present,
	}
	
	file { "/etc/rc.local":
		ensure => present,
		source => "puppet:///modules/terraria/rc.local",
		mode => 0775,
	}
	
}