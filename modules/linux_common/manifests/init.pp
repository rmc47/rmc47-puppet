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

  sshkey { 'bitbucket.org':
    type => 'ssh-rsa',
    key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw==',
  }
  sshkey { 'github.com':
    type => 'ssh-rsa',
    key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==',
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
