# /etc/puppet/modiles/sshd/manifests/init.pp


### Universal SSHD config based on the target hostname
class sshd::config {

    case $operatingsystem {
        /^CentOS|RedHat$/: {
            $sshd_svc    = "sshd"
            $sshd_client = "openssh-clients"
        }
        /^Ubuntu/: {
            $sshd_svc    = "ssh"
            $sshd_client = "openssh-client"
        }
    }

    package { openssh-server:  ensure => latest }
    package { "$sshd_client":  ensure => latest }

    ### Determine who can log into a host via sshd AllowGroups
    ### THIS IS A FIRST MATCH LOOKUP, BE CAREFUL
    case $fqdn  {
        /jenkins/                       : { $group_allow = 'all_dev'   }
        /^infl-myq/                     : { $group_allow = 'lab'       }
        /^infl.*/                       : { $group_allow = 'all_dev'   }
        /^nbu[dsaeqrtu]/                : { $group_allow = 'nobu_dev'  }
        /^chr[di]/                      : { $group_allow = 'nobu_dev'  }
        /^nobu.*dev/                    : { $group_allow = 'nobu_dev'  }
        /^nds.*dev/                     : { $group_allow = 'nobu_dev'  }
        /^dev[1234567890].*(mexi|zone)/ : { $group_allow = 'zone_dev'  }
        /^dev[1234567890].*nobu/        : { $group_allow = 'nobu_dev'  }
        /^nobu.*qa/                     : { $group_allow = 'nobu_qa'   }
        /^nds.*qa/                      : { $group_allow = 'nobu_qa'   }
        /^qa[1234567890].*(mexi|zone)/  : { $group_allow = 'zone_qa'   }
        /^qa[1234567890].*nobu/         : { $group_allow = 'nobu_qa'   }
        /^nobu.*stg/                    : { $group_allow = 'nobu_dev'  }
        /^(mex|nzo)[daeqrtf]-nmb/       : { $group_allow = 'zobu_dev'  }
        /^infd.*/                       : { $group_allow = 'zobu_dev'  }
        /^(mex|nzo)[daeqrtfg]/          : { $group_allow = 'zone_dev'  }
        /^snsdev/                       : { $group_allow = 'zone_dev'  }
	/^nzop-adm.*/                   : { $group_allow = 'zone_adm'  }
        /^lat.*/                        : { $group_allow = 'watchdog'  }
        /^isvp.*/                       : { $group_allow = 'watchdog'  }
        /^ghp.*/                        : { $group_allow = 'watchdog'  }
        /^sfcp.*/                       : { $group_allow = 'watchdog'  }
        /^coni-atl.*/                   : { $group_allow = 'watchdog'  }
        /^cosi-wik.*/                   : { $group_allow = 'watchdog'  }
        /^infa-png.*/                   : { $group_allow = 'watchdog'  }
        /^wdg.*/                        : { $group_allow = 'watchdog'  }
        /^nks.*/                        : { $group_allow = 'watchdog'  }
        /^sbt.*/                        : { $group_allow = 'watchdog'  }
        /^nof.*/                        : { $group_allow = 'nof'       }
        /^apl.*/                        : { $group_allow = 'apl'       }
        /^bfy[ds].*/                    : { $group_allow = 'backupify' }
        /^bfyp-cas.*/                   : { $group_allow = 'backupify' }
        /^bfyp-spa.*/                   : { $group_allow = 'backupify' }
        /^bfyp-wpa.*/                   : { $group_allow = 'backupify' }
        /^bfyp-fpa.*/                   : { $group_allow = 'backupify' }
        /^bfyp-frw.*/                   : { $group_allow = 'backupify' }
        /^bfyp-rem.*/                   : { $group_allow = 'backupify' }
        /^bfyp-res.*/                   : { $group_allow = 'backupify' }
        /^bfyp-gph.*/                   : { $group_allow = 'backupify' }
        /^bfyp-tls.*/                   : { $group_allow = 'backupify' }
        /^.*appleton.*/                 : { $group_allow = 'backupify' }
        /^nbui-had-.*/                  : { $group_allow = 'nobu_dev'  }
        /^dss.*/                        : { $group_allow = 'watchdog'  }
        /^csf.*/                        : { $group_allow = 'watchdog'  }
        /^mpl.*/                        : { $group_allow = 'watchdog'  }
        /^wap.*/                        : { $group_allow = 'watchdog'  }
        /^cpe.*/                        : { $group_allow = 'cpe'  }
        default                         : { $group_allow = 'prod'      }
    }

    file { "/etc/ssh/sshd_config":
        owner   => root,
        group   => root,
        mode    => 0600,
        content => template( "sshd/sshd_config.erb", "sshd/allow_groups_$group_allow.erb", "sshd/user_matches.erb" ),
        require => Package["openssh-server"],
    }

	file { '/etc/facter/facts.d/sshd_adgroupaccess':
        owner   => root,
        group   => root,
        mode    => '0755',
        source  => 'puppet:///modules/sshd/sshd_adgroupaccess',
        require => Package["openssh-server"],
    }

    service { "$sshd_svc":
        ensure    => running,
        subscribe => File["/etc/ssh/sshd_config"],
    }
}

class sshd::config::infrastructure {

    package { openssh-server: ensure => latest }

    file { "/etc/ssh/sshd_config":
        owner   => root,
        group   => root,
        mode    => 0600,
        content => template( "sshd/sshd_config.erb", "sshd/allow_groups_prod.erb" ),
        require => Package["openssh-server"],
    }

    case $operatingsystem {
        /^CentOS|RedHat$/: {
            $sshd_svc = "sshd"
        }
        /^Ubuntu/: {
            $sshd_svc = "ssh"
        }
    }
    service { "$sshd_svc":
        ensure    => running,
        subscribe => File["/etc/ssh/sshd_config"],
    }
}
class sshd::config::infservices {

    package { openssh-server: ensure => latest }

    file { "/etc/ssh/sshd_config":
        owner   => root,
        group   => root,
        mode    => 0600,
	source  => "puppet:///modules/sshd/sshd_config-infservices",
	require => Package["openssh-server"],
    }

    case $operatingsystem {
        /^CentOS|RedHat$/: {
            $sshd_svc = "sshd"
        }
        /^Ubuntu/: {
            $sshd_svc = "ssh"
        }
    }
    service { "$sshd_svc":
        ensure    => running,
        subscribe => File["/etc/ssh/sshd_config"],
    }
}


### EOF
