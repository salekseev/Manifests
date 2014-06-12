################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

# Using tech community module razorsedge-snmp
class base::snmp_profile (
  $snmpsyscontact  = 'DL-CPE-MVP@symantec.com',
  $snmpreadonlystr = 'QuaquakWyRyac',
  ) {

  notify{"include base snmp_profile.pp": }
  notify{"Loading include base snmp_profile OS class": }

  #Use tech module to handle debian/redhat pkg/svc diff
  class { 'snmp':
    install_client => true,
    service_ensure => 'running',
  }

  #Use complete template instead of insertion
  file { 'snmpd.conf':
    content => template("base/snmp_snmpd.conf.erb"),
    path    => '/etc/snmp/snmpd.conf',
    owner   => 'root', group => 'root', mode => '0640',
    backup => ".$::timestamp",
    notify => Service["snmpd"],
  }
  
} # end of class
