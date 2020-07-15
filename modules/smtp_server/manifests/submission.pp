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
    extra_main_parameters => {
      # Push mails to OpenDKIM
      smtpd_milters => 'inet:127.0.0.1:8892',
      non_smtpd_milters => 'inet:127.0.0.1:8892',
      milter_default_action => 'accept',
    }
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

  file { '/etc/mail/dkim.keytable':
    ensure => file,
    content => 'syxiscouk syxis.co.uk:default:/etc/mail/dkim-keys/syxis.co.uk/default.private
chipperfieldname chipperfield.name:default:/etc/mail/dkim-keys/chipperfield.name/default.private',
    require => File['/etc/mail'],
  }
  file { '/etc/mail/dkim.signingtable':
    ensure => file,
    content => '*@syxis.co.uk syxiscouk
*@chipperfield.name chipperfieldname',
    require => File['/etc/mail'],
  }

  file_line { 'OpenDKIM KeyTable':
    line => 'KeyTable /etc/mail/dkim.keytable',
    path => '/etc/opendkim.conf',
    match => '^KeyTable',
    require => Package['opendkim'],
  }

  file_line {'OpenDKIM SigningTable':
    line => 'SigningTable refile:/etc/mail/dkim.signingtable',
    path => '/etc/opendkim.conf',
    match => '^SigningTable',
    require => Package['opendkim'],
  }

  file_line {'OpenDKIM inet socket':
    line => 'Socket inet:8892@localhost',
    path => '/etc/opendkim.conf',
    match => '^Socket',
    require => Package['opendkim'],
  }
}
