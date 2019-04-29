class dixprs::onewire_telemetry {

  # Enable the 1-wire kernel subsystem
  file_line { 'onewire_dtparam':
    path => '/boot/config.txt',
    line => 'dtoverlay=w1-gpio,gpiopin=4',
    ensure => present,
  }

  file { '/home/pi/onewire_telemetry.sh':
    ensure => file,
    content => template('dixprs/onewire_telemetry.sh.erb'),
    mode => '0755',
  }

  cron { 'OneWire Telemetry Beacon':
    minute => '*/2',
    command => '/home/pi/onewire_telemetry.sh',
    user => 'pi',
  }
}
