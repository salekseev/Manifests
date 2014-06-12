################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile
#
# This profile manages additions and removals of default packages

#Self contained profile - not using tech community module (yet)
class base::packages_profile {
  notice(">>> packages_profile.pp <<<")
  notify{"class base::packages_profile": }

  #CentOS/Ubuntu name diff do not matter for uninstall
  $purgepackages = [
    "bluez",
    "bluetooth",
    "joe",
    "logwatch",
  ]
  package { $purgepackages: ensure => absent }

  # Optional packages we want installed at build - common CentOS/Ubuntu
  $commonbasepkgs = [
    "facter",
    "ruby",
    "telnet",
    "tcpdump",
    #"chkconfig",	# not available in trusty repo
    "curl",
    "unzip",
    "screen",
    "zip",
    "bzip2",
    "wget",
    "nmap",
    "mc",
    "lynx",
    "traceroute",
    "strace",
    "git",
    "ethtool",
    "tmux",
    "dstat",
    "quota",
    "dos2unix",
    "htop",
  ]
  package { $commonbasepkgs: ensure => installed }

  # VM versus Physical
  if ($::is_virtual == "true") {
    package { "numactl": ensure => absent }
  } else {
    package { "numactl": ensure => installed }
  }

  # Optional packages we want installed at build - RedHat family names
  $commonredhatpkgs = [
    "augeas",		#Might move to puppet class
    "redhat-lsb-core",	#Could move to puppet class
    "oddjob-mkhomedir",	#Could move to sssd class
  ]

  # Optional packages we want installed at build - Debian family names
  $commondebianpkgs = [
    "augeas-tools"	#Might move to puppet class
  ]

  case $::osfamily {
    'RedHat': {
          $osspecificpkgs = $commonredhatpkgs
    }
    'Debian': {
          $osspecificpkgs = $commondebianpkgs
    }
    default: {
      case $::operatingsystem {
        default: {
          notice("Unsupported platform: ${::osfamily}/${::operatingsystem}")
          $osspecificpkgs = []
        }
      }
    }
  } # end of case osfamily
  package { $osspecificpkgs: ensure => installed }

}
