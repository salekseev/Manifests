################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

#Self contained profile - not using tech community module (yet)
class base::openssl_profile {

  notify{"include base openssl_profile.pp": }
  notify{"Loading include base openssl_profile OS class": }

  # Optional packages we want installed at build - RedHat family names
  $opensslredhatpkgs = [
    "openssl",
  ]

  # Optional packages we want installed at build - Debian family names
  $openssldebianpkgs = [
    "openssl",
    "libssl1.0.0",
  ]

  case $::osfamily {
    'RedHat': {
          $osopensslpkgs = $opensslredhatpkgs
    }
    'Debian': {
          $osopensslpkgs = $openssldebianpkgs
    }
    default: {
      case $::operatingsystem {
        default: {
          notice("Unsupported platform: ${::osfamily}/${::operatingsystem}")
          $osopensslpkgs = []
        }
      }
    }
  } # end of case osfamily
  package { $osopensslpkgs: ensure => latest }

} # end of class
