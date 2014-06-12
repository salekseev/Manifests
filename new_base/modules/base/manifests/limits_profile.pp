################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

# Using tech community module saz-limits
class base::limits_profile {

  notify{"include base limits_profile.pp": }
  notify{"Loading include base limits_profile OS class": }

    limits::limits { 'all_nofile':
      ensure     => present,
      user       => '*',
      limit_type => 'nofile',
      hard       => 65584,
      soft       => 65584,
    }

    limits::limits { 'root_nofile':
      ensure     => present,
      user       => 'root',
      limit_type => 'nofile',
      hard       => 65584,
      soft       => 65584,
    }

} # end of class
