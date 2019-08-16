node 'iodine' {
    include ::rmc_puppetmaster
}

node 'mb7um.cambridgerepeaters.net' {
  include ::linux_common
  include ::dixprs
  include ::dixprs::onewire_telemetry
}

node 'mb7ups', 'mb7upe', 'mb7upi' {
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
