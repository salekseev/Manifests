################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

#Self contained profile - not using tech community module (yet)
class base::policy_profile (
  $selinux = 'false',
  $apparmor = 'false') {

  notify{"include base policy_profile.pp": }
  notify{"Loading include base policy_profile OS class": }

  case $::osfamily {
    'RedHat': {
      notify{"policy_profile class - disable selinux": }
    
      file { "selinux_config":
        path    => "/etc/selinux/config",
        owner   => root,
        group   => root,
        mode    => 644,
        source  => [
          "puppet:///modules/base/selinux_config",
        ],
      }
    
      exec { "selinux-disable":
        command => "setenforce 0",
        onlyif    => "sestatus |grep -v -c -E 'disabled|permissive'",
      }
    }

    'Debian': {
      notify{"policy_profile class - remove apparmor": }
      $rmpackages = [
        "apparmor",
        "apparmor-utils",
      ]
      package { $rmpackages: ensure => absent }
    }

    default: {
      case $::operatingsystem {
        default: {
          notice("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }

  } # end of case osfamily

} # end of class
