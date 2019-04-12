class dixprs::user {

  group { 'pi':
    ensure => present,
  }
  ->
  user { 'pi':
    ensure => present,
    managehome => true,
    gid => "pi",
    shell => "/bin/bash",
    groups => ["dialout", "tty", "wheel"],
  }
  
}
