class smtp_server::submission {
  class { '::postfix::server':
    relayhost => '[boron.syxis.co.uk]',
    smtpd_tls_cert_file => '/etc/ssl/smtpd.crt',
    smtpd_tls_key_file => '/etc/ssl/smtpd.key',
    submission => true,
    postgrey => false,
    spamassassin => false,
  }
}
