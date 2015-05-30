class samba {
	package { "samba":
		ensure => present,
	}
	
	package { "rsync":
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

	file_line { 'Add checkinbox /etc/crontab':
  		path => '/etc/crontab', 
 		line => '* * * * * root /opt/checkinbox/',
	}

	file { "/opt/checkinbox":
        ensure => present,
        source => "puppet:///modules/samba/checkinbox",
    }

	file { "/data":
		ensure => directory,
	}

	file { "/data/games":
		ensure => directory,
		require => File["/data"],
	}

	file { "/data/inbox":
		ensure => directory,
		require => File["/data"],
		mode => 0777,
	}
	
	package { "clamav":
		ensure => present,
	}
}
