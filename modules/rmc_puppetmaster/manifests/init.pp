class rmc_puppetmaster {
  package { 'ruby':
    ensure => '2.5.1',
  }
  ->
  pakcage { 'r10k':
    ensure => '2.6.3',
    provider => 'gem',
  }
}
