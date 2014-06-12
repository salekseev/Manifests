################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile
#
# Base use profile/shell configuration

#Self contained profile - not using tech community module (yet)
class base::shell_profile {
  notice(">>> base::shell_profile settings <<<")
  notify{"class base::shell_profile": }

  ###############################################################
  ## FILEs

  case $::osfamily {
    'RedHat': {
          $bashrc = "bashrc"
          $profile = ".bash_profile"
    }
    'Debian': {
          $bashrc = "bash.bashrc"
          $profile = ".profile"
    }
    default: {
      case $::operatingsystem {
        default: {
          notice("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  } # end of case osfamily

  # Copy down entire source directory
  file { "/etc/skel/":
    ensure => directory,
    owner => 'root', group => 'root', mode  => '0644',
  }
  file { "/etc/skel/.bash_logout":
    source  => "puppet:///modules/base/skel/.bash_logout",
    owner => 'root', group => 'root', mode  => '0644',
    require => File["/etc/skel/"],
  }
  file { "/etc/skel/.bashrc":
    source  => "puppet:///modules/base/skel/.bashrc",
    owner => 'root', group => 'root', mode  => '0644',
    require => File["/etc/skel/"],
  }
  #use centos/ubuntu path
  file { "/etc/skel/$profile":
    source  => "puppet:///modules/base/skel/$profile",
    owner => 'root', group => 'root', mode  => '0644',
    require => File["/etc/skel/"],
  }
  file { "/etc/bashrc":
    path => "/etc/$bashrc",
    source  => "puppet:///modules/base/$bashrc",
    backup => ".$::timestamp",
    owner => 'root', group => 'root', mode  => '0644',
  }
  file { "/etc/profile":
    source  => [
      "puppet:///modules/base/profile_$::osfamily",
      "puppet:///modules/base/profile",
    ],
    backup => ".$::timestamp",
    owner => 'root', group => 'root', mode  => '0644',
  }
  file { "/etc/login.defs":
    source  => "puppet:///modules/base/login.defs",
    backup => ".$::timestamp",
    owner => 'root', group => 'root', mode  => '0644',
  }

  file { "/etc/profile.d/":
    ensure => directory,
    owner => 'root', group => 'root', mode  => '0755',
  }
  file {"prompt.sh":
    path    => "/etc/profile.d/prompt.sh",
    ensure  => file,
    owner   => root, group => root, mode => 0755,
    content    => template("base/profile.d/prompt.sh.erb"),
    require => File[ "/etc/profile.d/" ],
  }
  file {"title.sh":
    path    => "/etc/profile.d/title.sh",
    ensure  => file,
    owner   => root, group => root, mode => 0755,
    content    => template("base/profile.d/titlebar.sh.erb"),
    require => File[ "/etc/profile.d/" ],
  }
} # end of class
