class smtp_server::submission {
  class { '::postfix::server':
    relayhost => '[boron.syxis.co.uk]',
    smtpd_tls_cert_file => '/etc/ssl/smtpd.crt',
    smtpd_tls_key_file => '/etc/ssl/smtpd.key',
    submission => true,
    postgrey => false,
    spamassassin => false,
    smtpd_recipient_restrictions => ['permit_sasl_authenticated', 'reject'],
    daemon_directory => '/usr/lib/postfix/sbin', # Otherwise it leads to daemon_directory conflicting with shlib_directory 😡
    inet_interfaces => 'all', # Don't just bind to localhost
  }
}
