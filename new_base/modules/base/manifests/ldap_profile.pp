################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

#Self contained profile - not using tech community module (yet)
class base::ldap_profile {
  notice(">>> ldap_profile.pp <<<")
  notify{"class base::ldap_profile": }

  # packages we want installed at build - RedHat family names
  $ldapredhatpkgs = [
    "openldap",
    "openldap-devel",
  ]

  # packages we want installed at build - Debian family names
  $ldapdebianpkgs = [
    "ldap-utils",
    "libsasl2-modules-ldap",
  ]

  case $::osfamily {
    'RedHat': {
          $ldappackages = $ldapredhatpkgs
    }
    'Debian': {
          $ldappackages = $ldapdebianpkgs
    }
    default: {
      case $::operatingsystem {
        default: {
          notice("Unsupported platform: ${::osfamily}/${::operatingsystem}")
          $ldappackages = []
        }
      }
    }
  } # end of case osfamily
  package { $ldappackages: ensure => installed }

}
