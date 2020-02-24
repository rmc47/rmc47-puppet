class linux_common::rob {
  user { 'rob':
    ensure => present,
    gid => 'rob',
    groups => ['wheel','adm'],
    managehome => true,
    shell => '/bin/bash',
  }
  group { 'rob':
    ensure => present,
  }
  ssh_authorized_key { 'rob@is-robc-2019-04-29':
    user => 'rob',
    type => 'ssh-rsa',
    key => 'AAAAB3NzaC1yc2EAAAABJQAAAQEA1t4+D44jcRunyY20QWp6RAJ0ynJ2G8PBF8Q4Xk/j4SlWTLS8NWMzhgyIrxrmNOuCUI4g8KeNkIp4mCKODUJtl3h+EkKkZZ6Bfl0tC5nOflQ/OT4b7lXpkvBsli/foLZu022LdEzYC8KsyrjDCYk/EYdDOve46Sp5f9G5kfoIPIijpoQ+9R1M14N5H5YCKjf1woY8GXjnc1BdYoCCTfV3fIJjo2TzO9prrbQfgy3W6yrL3ejghpMv0k/CIvSIFcykiZ8MFBOz8n9w6Kd6lTuRQF55/UqX1Ng4/c7Qx8I8fsigwbH2QBeLUa4Uw/3g8bjxdmqewvnHUaoKNzQ3EGrhoQ==',
  }
  ssh_authorized_key { 'rob@indium':
    user => 'rob',
    type => 'ssh-rsa',
    key => 'AAAAB3NzaC1yc2EAAAABJQAAAQEAsvJG3fNgoAk0q+hfoIVypR07E1YX4At4q7sz5wFWjKft//XDs/OtGWhtFcSNcXOkzrT4ezPOUEuBLOgsAVGkAGODaqu3t9O3KLKncuJeFyjCUR7i0v735UKJVhhM6kDPz3v0bT9/u9JX5/CjcIaYXjq5BkDyIH4g/GIj1X39xFeA/amMtUe5u+21jbApzHyWdlnmX8qpebZflBiePPqtbHf1EP5o52KYhVXY85fLSgP+idRXWOPsr92aTOgk9gDmMsB7SpDeRbqXHnITQzAwG1jEB+EBDo40f9Ser7185c4M0+9U7trV/SUSbWB1Npxcpm8eqIZlSIROD07WFLQ5sQ==',
  }
  ssh_authorized_key { 'rob@bismuth-2019-02-16':
    user => 'rob',
    type => 'ssh-rsa',
    key => 'AAAAB3NzaC1yc2EAAAABJQAAAQEAv35sto7RGGUsiNC7RR8saZpEUDnKUjxesTdFotR+3wXibU3tBdN5y8v3jSsFf5E9Hm7beO2gAdzKrP10iyoB+niYI3ECIys8FfK45Gm0jPVMCzULIq84pZOt/ddJeYROXXf4IxYqsquBVoVnzMWRk5AEmadguaZCn1sugt5ov8mycaFWqNuCE4rvH5xiwtTMg6ufsROvvLqjHJILMBUZEpvCKkKTyyfd6Zn0VWOJtQUqqJVG/PgvHT1jZWS90faS+0n6pdlf9fd/JPvXLaDOdn7xq2g8GwCM/OzVH9+gB/qewcyFn0G4ikkToFjG5u2byKhRsWMeyAlEhdJcxIvGaw==',
  }
}
