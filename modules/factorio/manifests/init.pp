class factorio {
	exec { "download-factorio-tar":
		command => 'wget -qO- http://www.factorio.com/get-download/0.12.33/headless/linux64 > /opt/factorio.tgz',
		unless => 'test -f /opt/factorio.tgz ]',
	}

	package { "tmux":
		ensure => present,
	}

	exec { "extract-factorio":
		command => 'tar -C /opt -xzf /opt/factorio.tgz',
		require => Exec["download-factorio-tar"],
		unless => 'test -d /opt/factorio ]',
	}

	file { "/etc/rc.local":
		source => "puppet:///modules/factorio/rc.local",
		ensure => present,
	}
}
