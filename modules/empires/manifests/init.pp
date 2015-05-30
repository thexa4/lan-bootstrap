class empires($username = "", $password = "", $verification = "") {
	package { "wine":
		ensure => present,
	}
	
	package { "unrar":
		ensure => present,
	}
	
	file { "/opt/updatetool":
		ensure => directory,
	}
	
	file { "/opt/empires":
		ensure => directory,
	}
	
	exec { "download updatetool.rar":
		command => "wget -qO- http://didrole.com/UpdateTool/UpdateTool-0.3.rar > /opt/updatetool/updatetool.rar",
		unless => "[ -f /opt/updatetool/updatetool.rar ]",
		require => File["/opt/updatetool"],
	}
	
	exec { "extract updatetool.rar":
		command => "(cd /opt/updatetool/ && rar e updatetool.rar)",
		unless => "[ -f /opt/updatetool/UpdateTool.exe ]",
		require => [ Package["unrar"], Exec["download updatetool.rar"] ],
	}
	
	exec { "fetch empires":
		command => "/opt/updatetool/UpdateTool.exe -command install -game 17740 -dir /opt/empires/ -username $username -password $password -verify_all -steam_guard_code $verify",
		unless => "/bin/false",
		require => [ Exec["extract updatetool.rar"], Package["wine"] ],
	}
}