class game_cache {
  group { 'nginx':
    ensure => present,
  }

  user { 'nginx':
    ensure  => present,
    system  => true,
    gid     => 'nginx',
    require => Group['nginx'],
  }

  package { 'nginx':
    ensure  => present,
    require => [ File['/etc/apt/sources.list.d/nginx.list'], User['nginx'], Exec['refresh apt-get nginx'] ],
  }
  
  file { '/etc/nginx/lancache':
    ensure  => directory,
    source  => 'puppet:///modules/cache/lancache/lancache',
    recurse => true,
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/conf.d/steam.conf':
    ensure  => present,
    source  => 'puppet:///modules/cache/steam.conf',
    require => [ Package['nginx'], File['/etc/nginx/lancache'] ],
    notify  => Service['nginx'],
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => absent,
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  => present,
    source  => 'puppet:///modules/cache/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  service { 'nginx':
    ensure  => running,
    require => Package['nginx'],
  }
  
  file { '/root/nginx.key':
    ensure => file,
    source => 'puppet:///modules/cache/nginx.key',
  }
  
  exec { 'install nginx key':
    command => '/usr/bin/apt-key add /root/nginx.key',
    unless  => "/usr/bin/apt-key list | /bin/grep -q '<signing-key@nginx.com>'",
    require => File['/root/nginx.key'],
  }
  
  file { '/etc/apt/sources.list.d/nginx.list':
    ensure => file,
    source => 'puppet:///modules/cache/nginx.list',
  }
  
  exec { 'refresh apt-get nginx':
    command => '/usr/bin/apt-get update',
  }
  
  $www_list = [ '/data', '/data/www', '/data/www/cache',  '/data/www/cache/tmp', '/data/www/cache/installs',  '/data/www/cache/other', '/data/www/cache/steam' ]

  file { $www_list:
    ensure  => directory,
    owner   => 'nginx',
    group   => 'nginx',
    before  => Service['nginx'],
    require => Package['nginx'],
  }
  
}
