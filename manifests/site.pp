node default {
	Exec {
		path => '/bin;/sbin;/usr/bin;/usr/sbin',
	}
	
	hiera_include('classes')
}
