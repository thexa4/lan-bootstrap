class empires {
	package { "wine":
		ensure => present,
	}
	
	package { "unrar":
		ensure => present,
	}
	
	file { "/opt/updatetool":
		ensure => directory,
	}
	
	exec { "download updatetool.rar":
		command => "wget -qO- http://didrole.com/UpdateTool/UpdateTool-0.3.rar > /opt/updatetool/updatetool.rar",
		unless => "[ -f /opt/updatetool/updatetool.rar ]",
		requires => File["/opt/updatetool"],
	}
	
	exec { "extract updatetool.rar":
		command => "(cd /opt/updatetool/ && rar e updatetool.rar)",
		unless => "[ -f /opt/updatetool/UpdateTool.exe ]",
		requires => [ Package["unrar"], Exec["download updatetool.rar"] ],
	}	
}