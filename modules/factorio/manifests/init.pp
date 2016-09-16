class factorio {
  exec { 'download-factorio-tar':
    command => 'wget -qO- https://www.factorio.com/get-download/latest/headless/linux64 > /opt/factorio.tgz',
    unless  => 'test -f /opt/factorio.tgz',
  }

  package { 'tmux':
    ensure => present,
  }

  exec { 'extract-factorio':
    command => 'tar -C /opt -xzf /opt/factorio.tgz',
    require => Exec['download-factorio-tar'],
    unless  => 'test -d /opt/factorio',
  }

  exec { 'create-world':
    command => '/opt/factorio/bin/x64/factorio --create lan',
    require => Exec['extract-factorio'],
    unless  => 'test -f /opt/factorio/saves/lan.zip'
  }

  file { '/etc/rc.local':
    ensure => present,
    source => 'puppet:///modules/factorio/rc.local',
  }
}
