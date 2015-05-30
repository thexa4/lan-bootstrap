class empires {
	package { "wine":
		ensure => present,
	}
	
	package { "unrar":
		ensure => present,
	}
	
	exec { "download updatetool.rar":
		command => "wget -qO- http://didrole.com/UpdateTool/UpdateTool-0.3.rar > /opt/updatetool.rar",
		unless => "[ -f /opt/updatetool.rar" ]",
	}
}