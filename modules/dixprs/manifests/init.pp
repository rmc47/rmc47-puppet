class dixprs (
	$callsign, 
	$longitude, 
	$latitude, 
	$symbol,
	$beaconText,
	$aprsisHost,
	$aprsisFilter,
	$kissPort,
	$serialSpeed,
	) {

	require dixprs::install
  require dixprs::user

  # Message spool directory. $spooldir is used in the config file as well.
  $spooldir = '/home/pi/dixprs-spool'
  file { "$spooldir":
    ensure => directory,
    owner => 'pi',
  }

	# Make ourselves a nice config file from the template
	file { '/home/pi/dixprs/config.txt':
		ensure => file,
		content => template('dixprs/dixprsconfig.txt.erb'),
	}

	# Start DIXPRS on boot
	cron { 'dixprs-on-reboot':
		ensure => present,
		command => '/home/pi/dixprs/dixprs.py -c /home/pi/dixprs/config.txt',
		user => 'pi',
		special => 'reboot',
	}

	# Disable the RS232 console on the Pi, because it eats up the serial port
	exec { 'disable-console-tty':
		command => '/bin/sed -i "s/console=ttyAMA0[^\\ ]*\\ //" /boot/cmdline.txt',
		cwd => '/',
		unless => '/usr/bin/test ! -f /boot/cmdline.txt || /bin/grep -qv ttyAMA /boot/cmdline.txt',
	}
	exec { 'disable-console-tty-systemd':
		command => '/bin/systemctl mask serial-getty@ttyAMA0.service',
    onlyif => '/usr/bin/test -e /dev/ttyAMA0'
		# TODO: make this conditional so we only do it once
	}

}
