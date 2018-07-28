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
		enable => true,
		ensure => running,
	}
	
	file { '/etc/timezone':
	    ensure => present,
	    content => "Europe/London\n",
	}
	file { '/etc/localtime':
		ensure => "link",
		target => "/usr/share/zoneinfo/Europe/London",
	}
}
