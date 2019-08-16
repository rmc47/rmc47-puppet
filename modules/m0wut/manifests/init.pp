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

  file { '/var/www/wordpress.tar.gz':
    ensure => present,
    source => 'https://en-gb.wordpress.org/latest-en_GB.tar.gz',
    require => Package['apache2'],
    source_permissions => ignore,
  }

  exec { 'Unzip Wordpress':
    cmd => '/bin/tar xzf /var/www/wordpress.tar.gz --strip-components=1',
    cwd => '/var/www/html',
    creates => '/var/www/html/index.php',
    require => File['/var/www/wordpress.tar.gz'],
  }
}
