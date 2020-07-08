class crg_web_server {
  require ::linux_common
  require ::linux_common::rob

  package { [
    'certbot',
    'mariadb-client',
    'mariadb-server',
    'nginx',
    'php7.4',
    'php7.4-cli',
    'php7.4-fpm',
    'php7.4-mysql',
    'python3-certbot-nginx',
    ]:
    ensure => installed,
  }

  package { 'apache2':
    ensure => absent,
  }
}
