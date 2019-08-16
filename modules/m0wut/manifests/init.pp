class m0wut {
    
  package { [
    'apache2',
    'mariadb-server',
    'mariadb-client',
    'php',
    'libapache2-mod-php',
    'php-mysql',
    ]:
    ensure => present,
  }
}
