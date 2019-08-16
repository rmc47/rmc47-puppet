class m0wut ($site_hostname) {

  package { [
    'apache2',
    'mariadb-server',
    'mariadb-client',
    'php',
    'libapache2-mod-php',
    'php-mysql',
    'certbot',
    'python-certbot-apache',
    ]:
    ensure => present,
  }

  exec { 'Download Wordpress':
    command => '/usr/bin/wget https://en-gb.wordpress.org/latest-en_GB.tar.gz -O /var/www/wordpress.tar.gz',
    creates => '/var/www/wordpress.tar.gz',
    require => Package['apache2'],
  }

  exec { 'Unzip Wordpress':
    command => '/bin/tar xzf /var/www/wordpress.tar.gz --strip-components=1',
    cwd => '/var/www/html',
    creates => '/var/www/html/index.php',
    require => Exec['Download Wordpress'],
  }

  exec { 'Create WP database':
    command => '/usr/bin/mysql -e "CREATE DATABASE m0wut_wordpress;"',
    unless => '/usr/bin/mysql -e "SHOW DATABASES" | grep m0wut_wordpress',
    require => Package['mariadb-server'],
  }

  exec { 'Create WP database user':
    command => '/usr/bin/mysql -e "CREATE USER \'www-data\'@localhost IDENTIFIED VIA unix_socket; GRANT ALL ON m0wut_wordpress.* TO \'www-data\'@localhost; FLUSH PRIVILEGES;"',
    unless => '/usr/bin/mysql -e "SELECT * FROM mysql.user" | grep www-data',
    require => Exec['Create WP database'],
  }

  # Grab ourselves some unique salts
  exec { 'Create /var/www/html/wp-salts.php':
    command => 'echo "<?php" > /var/www/html/wp-salts.php && /usr/bin/curl https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/html/wp-salts.php',
    creates => '/var/www/html/wp-salts.php',
    provider => 'shell',
    require => Package['apache2'],
  }

  file { '/var/www/html/wp-config.php':
    ensure => present,
    content => template('m0wut/wp-config.php.erb'),
    require => Package['apache2'],
  }

  exec { 'Configure SSL':
    command => "/usr/bin/certbot --apache --agree-tos --domain ${site_hostname} --redirect --email robert@syxis.co.uk --no-eff-email",
    creates => "/etc/letsencrypt/live/${site_hostname}/cert.pem",
  }

  file { '/var/www/html/index.html':
    ensure => absent,
  }
}
