################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

class base::lldp_profile {

  notify{"include base lldp_profile.pp": }
  notify{"Loading include base::lldp_profile": }

  #Install lldp only for bare metal servers
  if ( !str2bool($::is_virtual)) {
    class {'::lldp':}
  }
} # end of class
