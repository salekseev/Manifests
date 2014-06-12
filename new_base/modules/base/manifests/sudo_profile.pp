################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

# Using tech community module saz-sudo
class base::sudo_profile {


  notify{"include base sudo_profile.pp": }
  notify{"Loading include base sudo_profile OS class": }

  class { 'sudo':
    purge               => false, #TODO - switch to true once we have role profiles running with
    config_file_replace => true,  #Installs STOCK /etc/sudoers based on OS
  }

  # Default - all hosts have this sudo environment
  sudo::conf { 'environment':
    priority => 5,
    source   => 'puppet:///modules/base/sudoers.d/environment',
  }
  # Default - all hosts allow local wheel as convention
  sudo::conf { 'wheel':
    priority => 10,
    content  => "%wheel       ALL=(ALL)       ALL",
  }
  # Default - all hosts allow CPE linux administrators
  sudo::conf { 'symcpe_lnx_adm':
    priority => 10,
    content  => "%symcpe.lnx.adm       	ALL=(ALL)	ALL",
  }
  # Default - all hosts allow CPE Security scans
  sudo::conf { 'symcpe_secscan_lnx_adm':
    priority => 10,
    content  => "%symcpe.secscan.lnx.adm       	ALL=(ALL)	ALL",
  }
  # Default - all hosts allow CPE network administrators
  sudo::conf { 'net_lnx_adm':
    priority => 10,
    content  => "%net.lnx.adm       	NETTOOLS=(ALL)	ALL",
  }
  # Default - all hosts allow CPE NOC
  sudo::conf { 'symcpe_noc_lnx_adm':
    priority => 10,
    content  => "%symcpe.noc.lnx.adm       	ALL=(ALL)	OPERATOR",
  }

} # end of class
