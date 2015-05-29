class trackmania {
	package { "mysql":
		ensure => present,
	}
	
	package { "php5":
		ensure => present,
	}
	
	exec { "extract dedicated trackmania server":
		command => "wget -qO- http://kheops.unice.fr/Slig/tm/dedicated/TmDedicatedServer_2006-05-30.zip > /opt/tmdedicated.zip && unzip /opt/tmdedicated.zip",
		unless => "[ -f /opt/tmdedicated.zip ]",
	}
}