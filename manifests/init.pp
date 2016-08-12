# Class: monyog
class monyog (
  $basedir = '/usr/local/MONyog',
  $inifile = "${basedir}/MONyog.ini",
  $port    = 5555,
) {

  package { 'MONyog':
    ensure => installed,
  }

  ini_setting { 'Port':
    path    => $inifile,
    section => 'GENERAL',
    setting => 'Port'
    value   => $port,
    require => Package['MONyog'],
    notify  => Service['MONyogd'],
  }

  firewall { '100-monyog':
    proto  => 'tcp',
    dport  => $port,
    action => 'accept',
  }

  service { 'MONyogd':
    ensure  => running,
    enable  => true,
    require => Package['MONyog'],
  }

}
