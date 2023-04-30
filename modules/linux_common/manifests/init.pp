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
  
  sshkey { 'github.com':
    type => 'ssh-rsa',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=',
  }
}
