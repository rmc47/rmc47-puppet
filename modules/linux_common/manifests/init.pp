class linux_common {
  package {'vim':
    ensure => latest,
  }

  package { 'ntp':
    ensure => latest,
  }

  package { 'git':
    ensure => latest,
  }

  service {'ntp':
    ensure => running,
    require => Package['ntp'],
  }

  service { 'ssh':
    ensure => running,
    enable => true,
  }

  file { '/etc/timezone':
      ensure => present,
      content => "Europe/London\n",
  }
  file { '/etc/localtime':
    ensure => 'link',
    target => '/usr/share/zoneinfo/Europe/London',
  }

  group { 'group_wheel':
    name => "wheel",
    ensure => present,
  }

  sudo::conf {'Wheel local admins':
    priority => 9,
    content => '%wheel ALL=(ALL) NOPASSWD:ALL'
  }
}
