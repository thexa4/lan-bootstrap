class openttd(
  $version = '1.6.1',
  $gfx_version = '0.5.2',
){

  exec { 'install openttd':
    command => "wget -qO- http://binaries.openttd.org/releases/${version}/openttd-${version}-linux-generic-amd64.tar.gz | gunzip | tar -xC /opt/",
    creates => "/opt/openttd-${version}-linux-generic-amd64",
  }

  exec { 'download openttd-opengfx':
    command => "wget -qO- http://binaries.openttd.org/extra/opengfx/${gfx_version}/opengfx-${gfx_version}-all.zip > /tmp/opengfx.zip && unzip /tmp/opengfx.zip -d /root/.openttd/baseset && rm /tmp/opengfx.zip",
    creates => "/root/.openttd/baseset/opengfx-${gfx_version}.tar",
    require => [ Package['unzip'], File['/root/.openttd/baseset'] ],
  }

  package { 'unzip':
    ensure => present,
  }

  package { 'libsdl1.2debian':
    ensure => present,
  }

  package { 'libfontconfig':
    ensure => present,
  }

  file { '/opt/openttd':
    ensure => link,
    target => "/opt/openttd-${version}-linux-generic-amd64",
  }

  file { '/root/.openttd':
    ensure => directory,
  }

  file { '/root/.openttd/baseset':
    ensure  => directory,
    require => File['/root/.openttd'],
  }

  package { 'tmux':
    ensure => present,
  }

  file { '/etc/rc.local':
    ensure => present,
    source => 'puppet:///modules/openttd/rc.local',
    mode   => '0775',
  }
}
