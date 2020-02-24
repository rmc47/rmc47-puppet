class certbot_http01 {
  package { 'certbot':
    ensure => latest,
  }
}
