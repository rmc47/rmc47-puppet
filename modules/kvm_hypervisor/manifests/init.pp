class kvm_hypervisor {
    
  package { ['qemu-kvm', 'libvirt-bin', 'virtinst', 'bridge-utils', 'cpu-checker']:
    ensure => present,
  }
  
}
