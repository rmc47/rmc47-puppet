class syxis_authoritative_dns {

  # theforeman/dns
  include ::dns

  $buddyns_transfer_hosts = [
    "108.61.224.67",
    "116.203.6.3",
    "107.191.99.111",
    "185.22.172.112",
    "103.6.87.125",
    "192.184.93.99",
    "119.252.20.56",
    "31.220.30.73",
    "185.34.136.178",
    "185.136.176.247",
    "45.77.29.133",
    "116.203.0.64",
    "167.88.161.228",
    "199.195.249.208",
    "104.244.78.122",
    "2605:6400:30:fd6e::3",
    "2605:6400:10:65::3",
    "2605:6400:20:d5e::3",
    "2a01:4f8:1c0c:8122::3",
    "2001:19f0:7001:381::3",
    "2a06:fdc0:fade:2f7::1",
    "2a00:dcc7:d3ff:88b2::1",
    "2a04:bdc7:100:1b::3",
    "2401:1400:1:1201::1:7853:1a5",
    "2604:180:1:92a::3",
    "2403:2500:4000::f3e",
    "2a00:1838:20:2::cd5e:68e9",
    "2604:180:2:4cf::3",
    "2a01:4f8:1c0c:8115::3",
    "2001:19f0:6400:8642::3",
  ]

  $zones = [
    "syxis.co.uk",
    "112-119.248.187.81.in-addr.arpa",
    "20thgillingham.com",
    "camb-hams.com",
    "cambridgerepeaters.net",
    "cambridgeshire-raynet.net",
    "chipperfield.name",
    "codeandcarriers.co.uk",
    "eximius-computing.co.uk",
    "g3pye.org",
    "gb3pi.org.net",
    "gb7pi.net",
    "hamtechtalks.com",
    "keywi.co.uk",
    "m0vfc.co.uk",
    "pod.me.uk",
    "qrqsl.com",
    "qrqsl.org",
  ]

  $zones.each | String $zone | {
    dns::zone { $zone:
      manage_file => false,
      manage_file_name => true,
      allow_query => ['any'],
      allow_transfer => $buddyns_transfer_hosts,
      filename => "${zone}.zone",
    }
  }

  file { '/opt/dnscontrol':
    ensure => 'directory',
  }
  file { '/opt/dnscontrol/bin':
    ensure => 'directory',
    require => File['/opt/dnscontrol'],
  }

  exec { 'Download dnscontrol':
    command => "/usr/bin/wget \"https://github.com/StackExchange/dnscontrol/releases/download/v3.15.0/dnscontrol-Linux\" -O /opt/dnscontrol/bin/dnscontrol && /bin/chmod +x /opt/dnscontrol/bin/dnscontrol",
    require => File['/opt/dnscontrol/bin'],
    creates => "/opt/dnscontrol/bin/dnscontrol",
  }

  vcsrepo { '/opt/dnscontrol/rmc47-dns':
    ensure => latest,
    provider => git,
    source => 'git@github.com:rmc47/rmc47-dns.git',
    require => [ Package['git'] ],
    revision => 'master',
  }

  file { '/opt/dnscontrol/rmc47-dns/creds.json':
    content => '{
      "bind": { "directory": "/var/cache/bind/zones" }
    }',
    require => Vcsrepo['/opt/dnscontrol/rmc47-dns'],
  }

  exec { 'Regenerate DNS zones':
    refreshonly => true,
    subscribe => Vcsrepo['/opt/dnscontrol/rmc47-dns'],
    command => '/opt/dnscontrol/bin/dnscontrol push',
    cwd => '/opt/dnscontrol/rmc47-dns',
    require => [
      Exec['Download dnscontrol'],
      File['/opt/dnscontrol/rmc47-dns/creds.json'],
      Vcsrepo['/opt/dnscontrol/rmc47-dns'],
    ],
    notify => Service['bind9'],
  }
}
