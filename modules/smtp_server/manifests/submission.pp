class smtp_server::submission {
  class { '::postfix::server':
    relayhost => '[boron.syxis.co.uk]',
  }
}
