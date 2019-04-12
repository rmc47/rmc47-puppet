class dixprs::user {

  user { 'pi':
    ensure => present,
    managehome => true,
    gid => "pi",
    shell => "/bin/bash",
  }
  
}
