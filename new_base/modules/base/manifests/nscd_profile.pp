################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

# Using tech community module ghoneycutt-nscd
class base::nscd_profile {

  notice("nscd_profile caching hosts only")
  notify{"include base nscd_profile.pp": }
  notify{"Loading include base nscd_profile OS class": }

  class { 'nscd':
    package_ensure => 'present',
    service_ensure => 'running',
    service_enable => 'true',
    threads => '1',
    max_threads => '2',
    hosts_enable_cache => 'yes',
    hosts_positive_time_to_live => '300',
    hosts_negative_time_to_live => '20',
    passwd_enable_cache => 'no',
    group_enable_cache => 'no',
    services_enable_cache => 'no',
  }
} # end of class
