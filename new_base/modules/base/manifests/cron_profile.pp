################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

#Self contained profile - not using tech community module (yet)
class base::cron_profile {
  notice(">>> base cron_profile.pp <<<")
  notify{"class base::cron": }

  ##PACKAGE
  package { "cron":
    name       => $::osfamily ? {
      debian   => 'cron',
      redhat   => 'cronie',
      default  => 'cron',
    },
    ensure     => installed,
  }

  ##SERVICE
  service { "cron":
    name       => $::osfamily ? {
      debian   => 'cron',
      redhat   => 'crond',
      default  => 'crond',
    },
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package ["cron"],
  }

  ##FILES
  file { "/etc/cron.d":
    owner => root,
    group => root,
    mode => 644,
    recurse => true,
  }

}
