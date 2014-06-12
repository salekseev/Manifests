################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

# Using tech community module razorsedge-snmp
class base::timezone_profile {

  notify{"include base timezone_profile.pp": }
  notify{"Loading include base timezone_profile OS class": }

  class { 'timezone':
    timezone => 'UTC',
  }
} # end of class
