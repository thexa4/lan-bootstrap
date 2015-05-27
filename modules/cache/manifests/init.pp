class cache {
	package { "nginx":
		ensure => present,
	}
	
	exec { "download nginx-cache config":
		command => "/usr/bin/wget -qO- http://blog.multiplay.co.uk/dropzone/lancache-386.tgz | gunzip | /bin/tar -xC /etc/nginx/ lancache",
		unless => "/usr/bin/test -d /etc/nginx/lancache",
	}
	
	file { "/etc/nginx/sites-available/steam":
		ensure => present,
		source => "puppet:///modules/cache/steam",
	}
	
	file { "/etc/nginx/sites-enabled/steam":
		ensure => link,
		target => "/etc/nginx/sites-available/steam",
		notify => Service["nginx"],
	}
	
	service { "nginx":
		ensure => running,
	}
}