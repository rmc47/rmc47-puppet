class rmc_puppetmaster {
  package { 'ruby':
    ensure => '1:2.5.1',
  }
  ->
  package { 'r10k':
    ensure => '2.6.3',
    provider => 'gem',
  }
  ->
  file { '/etc/puppetlabs/r10k':
    ensure => 'directory',
  }
  ->
  file { '/etc/puppetlabs/r10k/r10k.yaml':
    content => template('rmc_puppetmaster/r10k.yaml.erb'),
  }
}
