class smtp_server::submission {

  # Postfix uses Dovecot for SASL auth
  package { 'dovecot-core':
    ensure => latest,
  }

  package { ['opendkim-tools', 'opendkim']:
    ensure => installed,
  }

  # TODO: template dovecot 10-master.conf
  # TODO: template login for 10-auth.conf
  # TODO: add Wants=dovecot to /lib/systemd/system/postfix.service

  class { '::postfix::server':
    relayhost => '[boron.syxis.co.uk]',
    ssl => true,
    smtpd_tls_cert_file => '/etc/letsencrypt/live/smtp.syxis.co.uk/fullchain.pem',
    smtpd_tls_key_file => '/etc/letsencrypt/live/smtp.syxis.co.uk/privkey.pem',
    submission => true,
    postgrey => false,
    spamassassin => false,
    smtpd_recipient_restrictions => ['permit_sasl_authenticated', 'reject'],
    daemon_directory => '/usr/lib/postfix/sbin', # Otherwise it leads to daemon_directory conflicting with shlib_directory 😡
    inet_interfaces => 'all', # Don't just bind to localhost
    smtpd_sasl_auth  => true, # enable SASL auth (defaults to Dovecot)
  }

  user { [
    'rpc21',
    'terry',
    'maureen',
    'bl2000',
    'jlw200'
    ]:
    ensure => present,
    shell => '/bin/false',
  }

  file { '/etc/mail':
    ensure => directory,
  }
  file { '/etc/mail/dkim-keys':
    ensure => directory,
    require => File['/etc/mail'],
  }

  file { '/etc/mail/dkim.key':
    ensure => file,
    content => '
      *@syxis.co.uk:syxis.co.uk:/etc/mail/dkim-keys/syxis.co.uk/dt.private
      *@chipperfield.name:chipperfield.name:/etc/mail/dkim-keys/chipperfield.name/dt.private
      ',
    require => File['/etc/mail'],
  }
}
