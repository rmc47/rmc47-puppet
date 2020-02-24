class certbot_http01 {
  package { 'nginx':
    ensure => latest,
  }
  package { ['certbot', 'python3-certbot-nginx']:
    ensure => latest,
  }
}
