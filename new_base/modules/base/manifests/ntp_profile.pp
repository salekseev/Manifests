################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

# Using tech community module saz-ntp
class base::ntp_profile (
  $ntpip1 = '10.177.6.23',
  $ntpip2 = '10.125.6.23',
  $ntpip3 = '10.117.6.23',) {

  #TODO - have override by $datacenter for dnsip1/2 or use 'fact'

  notify{"include base ntp_profile.pp": }
  notify{"Loading include base ntp_profile OS class": }

  class { 'ntp':
    server_list        => [ "$ntpip1 iburst", "$ntpip2 iburst", "$ntpip3 iburst", ],
    ensure             => present,
    service_enable     => true,
    service_ensure     => running,
    service_hasstatus  => true,
    service_hasrestart => true,
    #server_enabled => true, #On ntp servers only
  }

} # end of class
