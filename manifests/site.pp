node 'iodine' {
    include ::rmc_puppetmaster
}

node 'mb7um.cambridgerepeaters.net' {
  include ::linux_common
  include ::dixprs
}

node 'mb7ups', 'mb7upe', 'mb7upi.cambridgerepeaters.net' {
  include ::linux_common
  include ::dixprs
}
