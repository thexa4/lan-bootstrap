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
		command => "wget -qO- http://slig.free.fr/TM/dedicated/TmDedicatedServer_2006-05-30.zip > /opt/tmdedicated.zip && unzip /opt/tmdedicated.zip",
		unless => "[ -d /opt/TmDedicatedServer ]",
		require => Package["unzip"],
	}
	
	package { "tmux":
		ensure => present,
	}
	
	file { "/etc/rc.local":
		ensure => file,
		source => "puppet:///modules/trackmania/rc.local",
	}
	
	file { "/opt/TmDedicatedServer/dedicated.cfg":
		ensure => file,
		source => "puppet:///modules/trackmania/dedicated.cfg",
		require => Exec["extract dedicated trackmania server"],
	}
}