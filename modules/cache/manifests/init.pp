class cache {
	package { "nginx":
		ensure => present,
	}
	
	exec { "download nginx-cache config":
		command => "/usr/bin/wget -qO- http://blog.multiplay.co.uk/dropzone/lancache-386.tgz | gunzip | /bin/tar -xC /etc/nginx/ lancache",
		unless => "/usr/bin/test -d /etc/nginx/lancache",
	}
}