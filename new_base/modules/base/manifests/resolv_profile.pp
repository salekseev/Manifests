################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

# Using tech community module saz-resolv_conf
class base::resolv_profile (
  $dnsip1 = '10.116.1.10',
  $dnsip2 = '10.116.1.11',
  $topdomain = 'symcpe.net') {

  #TODO - have override by $datacenter for dnsip1/2 or use 'fact'

  notify{"include base resolv_profile.pp": }
  notify{"Loading include base resolv_profile OS class": }

  #TODO? exclude dns servers
  class { 'resolv_conf':
      domainname => "$::domain",
      nameservers => ["$dnsip1","$dnsip2",],
      searchpath  => ["$::domain","$topdomain",],
  }

} # end of class
