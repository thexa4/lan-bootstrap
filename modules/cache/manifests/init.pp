class cache {
	package { "nginx":
		ensure => present,
		require => [ File["/etc/apt/sources.list.d/nginx.list"], Exec["refresh apt-get nginx"] ],
	}
	
	exec { "download nginx-cache config":
		command => "/usr/bin/wget -qO- http://blog.multiplay.co.uk/dropzone/lancache-386.tgz | gunzip | /bin/tar -xC /etc/nginx/ lancache",
		unless => "/usr/bin/test -d /etc/nginx/lancache",
		require => Package["nginx"],
	}
	
	file { "/etc/nginx/conf.d/steam":
		ensure => present,
		source => "puppet:///modules/cache/steam",
		require => Package["nginx"],
		notify => Service["nginx"],
	}
	
	service { "nginx":
		ensure => running,
		require => Package["nginx"],
	}
	
	file { "/root/nginx.key":
		ensure => file,
		source => "puppet:///modules/cache/nginx.key",
	}
	
	exec { "install nginx key":
		command => "/usr/bin/apt-key add /root/nginx.key",
		unless => "/usr/bin/apt-key list | /bin/grep -q Nginx",
		require => File["/root/nginx.key"],
	}
	
	file { "/etc/apt/sources.list.d/nginx.list":
		ensure => file,
		source => "puppet:///modules/cache/nginx.list",
	}
	
	exec { "refresh apt-get nginx":
		command => "/usr/bin/apt-get update",
	}
	
	$www_list = [ '/data', '/data/www', '/data/www/cache',  '/data/www/cache/tmp', '/data/www/cache/installs',  '/data/www/cache/other', '/data/www/cache/steam' ]

	file { $www_list:
	  ensure => directory,
	  owner  => 'www-data',
	  group  => 'www-data',
	  before => Service['nginx'],
	}
	
}