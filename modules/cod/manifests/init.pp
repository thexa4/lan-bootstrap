class cod {
	package { "screen":
		ensure => present,
	}

	exec { "add-i386":
        	command => '/usr/bin/dpkg --add-architecture i386',
        	unless => '/usr/bin/dpkg --print-foreign-architectures | /bin/grep i386',
     	}

	exec { "/usr/bin/apt-get update":
		command => '/usr/bin/apt-get update',
		require => Exec["add-i386"],
	}

        exec { "download-tar": 
                command => 'wget http://treefort.icculus.org/cod/cod4-linux-server-06282008.tar.bz2',
                unless => 'ls / | /bin/grep cod4-linux-server-06282008.tar.bz2',
		require => [ File["/opt/cod4server"], Exec["/usr/bin/apt-get update"] ],
        }

	exec { "extract-package":
		command => 'tar -xvjf cod4-linux-server-06282008.tar.bz2 -C /opt/cod4server',
		unless => 'ls /opt/cod4server | grep cod4-linux-server',
		require => Exec["download-tar"],
	}
	
	service { "cod4server":
		ensure => running,
		require => File["/etc/init.d/cod4server"],
	}
	
	file { "/opt/cod4server/general.cfg":
		ensure => present,
		source => "puppet:///modules/cod4/general.cfg",
		require => Exec["extract-package"],
		notify => Service["cod4server"],
	}

        file { "/etc/init.d/cod4server":
                ensure => present,
                source => "puppet:///modules/cod4/cod4serverinit",
		require => File["/opt/cod4server/cod4server"],
        }


	file { "/opt/cod4server":
		ensure => directory,
	}

        file { "/opt/cod4server/cod4server":
                ensure => present,
                source => "puppet:///modules/samba/smb.conf",
                require => [ File["/opt/cod4server"], Exec["extract-package"], Package["screen"] ],
        }
}

