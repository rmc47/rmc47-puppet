class certbot_http01 {
  package { 'nginx':
    ensure => latest,
  }
  package { 'certbot':
    ensure => latest,
  }
}
