class trackmania {
	package { "mysql-server":
		ensure => present,
	}

	package { "unzip":
		ensure => present,
	}

	package { "php5":
		ensure => present,
	}

	exec { "extract dedicated trackmania server":
		command => "wget -qO- http://files2.trackmaniaforever.com/TrackmaniaServer_2011-02-21.zip > /opt/tmdedicated.zip && unzip /opt/tmdedicated.zip -d /opt/TmDedicatedServer",
		unless => "[ -d /opt/TmDedicatedServer ]",
		require => Package["unzip"],
	}

	package { "tmux":
		ensure => present,
	}

	file { "/etc/rc.local":
		ensure => file,
		source => "puppet:///modules/trackmania/rc.local",
		mode => 0775,
	}

	file { "/opt/TmDedicatedServer/dedicated.cfg":
		ensure => file,
		source => "puppet:///modules/trackmania/dedicated.cfg",
		require => Exec["extract dedicated trackmania server"],
	}
}
