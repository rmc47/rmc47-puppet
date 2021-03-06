node 'iodine' {
  include ::rmc_puppetmaster
}

node 'mb7um.cambridgerepeaters.net','mb7vc.cambridgerepeaters.net' {
  include ::linux_common
  include ::dixprs
  include ::dixprs::onewire_telemetry
}

node 'mb7ups', 'mb7upe', 'mb7upi', 'mb7uc' {
  include ::linux_common
  include ::dixprs
}

node 'mercury.syxis.co.uk' {
  include ::linux_common
  include ::syxis_authoritative_dns
}

node 'm0wut.syxis.co.uk' {
  include ::linux_common
  include ::m0wut
}

node 'diamond.syxis.co.uk' {
  include ::linux_common
  include ::kvm_hypervisor
}

node 'bromine.syxis.co.uk' {
  include ::linux_common
  include ::linux_common::rob
  include ::certbot_http01
  include ::smtp_server::submission
}

node 'calcium.syxis.co.uk' {
  include ::crg_web_server
}
