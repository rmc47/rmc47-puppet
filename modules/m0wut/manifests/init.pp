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
    command => '/bin/tar xzf /var/www/wordpress.tar.gz --strip-components=1',
    cwd => '/var/www/html',
    creates => '/var/www/html/index.php',
    require => File['/var/www/wordpress.tar.gz'],
  }

  exec { 'Create WP database':
    command => '/usr/bin/mysql -e "CREATE DATABASE m0wut_wordpress;"',
    unless => '/usr/bin/mysql -e "SHOW DATABASES" | grep m0wut_wordpress',
    require => Package['mariadb-server'],
  }

  exec { 'Create WP database user':
    command => '/usr/bin/mysql -e "CREATE USER \'www-data\'@localhost IDENTIFIED VIA unix_socket; GRANT ALL ON m0wut_wordpress.* TO \'www-data\'@localhost; FLUSH PRIVILEGES;',
    unless => '/usr/bin/mysql -e "SELECT * FROM mysql.user" | grep www-data',
    require => Exec['Create WP database'],
  }
  
  # Grab ourselves some unique salts
  file { '/var/www/html/wp-salts.php':
    ensure => present,
    source => 'https://api.wordpress.org/secret-key/1.1/salt/',
    require => Package['apache2'],
    source_permissions => ignore,
  }

  file { '/var/www/html/wp-config.php':
    ensure => present,
    content => template('m0wut/wp-config.php.erb'),
    require => Package['apache2'],
  }
}
