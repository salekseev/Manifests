### Remove the bad console line for Xen
class server::ubuntu::ssd_fix {
    if $lsbmajdistrelease == '12' {
        file { "/etc/init/sssd.conf":
            ensure => present,
            owner   => root,
            group   => root,
            mode    => 0755,
            source  => "puppet:///modules/server/ubuntu_init_sssd.conf",
        }
    }
}

class server::timezone {

    file { "/etc/localtime":
        ensure => "/usr/share/zoneinfo/GMT",
    }

    case $operatingsystem {
        /^CentOS|RedHat$/: {
            file { "/etc/sysconfig/clock":
                ensure  => present,
                source  => "puppet:///modules/server/clock",
            }
        }
        /[Uu]buntu/: {
            file { "/etc/timezone":
                owner   => root,
                group   => root,
                mode    => 0644,
                content => 'Etc/GMT',
            }

            exec { "reconfigure-tzdata":
                command     => "/usr/sbin/dpkg-reconfigure --frontend noninteractive tzdata",
                subscribe   => File["/etc/localtime"],
                require     => File["/etc/localtime"],
                refreshonly => true,
            }

        }
    }
}

class server::limits {

    file { "/etc/security/limits.d/90-nproc.conf":
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/server/90-nproc.conf',
    }

#    file { "/etc/security/limits.conf":
#        owner  => 'root',
#        group  => 'root',
#        mode   => '0640',
#        source => [
#                              "puppet:///modules/server/limits.conf.$host_role",
#                              "puppet:///modules/server/limits.conf",
#        ],
#    }
}

class server::sysctl {
#    file { "/etc/sysctl.conf":
#        owner          => root,
#        group          => root,
#        mode           => 0640,
#        source         => [
#                              "puppet:///modules/server/sysctl.conf.$host_role.$datacenter",
#                              "puppet:///modules/server/sysctl.conf.$host_role",
#                              "puppet:///modules/server/sysctl.conf",
#        ],
#    }
#
#    exec { "sysctl -p":
#         path          => ["/sbin", "/usr/sbin"],
#         subscribe     => File[ "/etc/sysctl.conf" ],
#         timeout       => 30,
#         refreshonly   => true,
#    }
}

class server::rclocal {
    file { "/etc/rc.d/rc.local":
        owner          => root,
        group          => root,
        mode           => 0755,
        source         => [
                              "puppet:///modules/server/rc.local.$host_role",
                              "puppet:///modules/server/rc.local",
        ],
    }
}

class server::logrotate {
    package { "logrotate": ensure => latest }
    file { "/etc/logrotate.d/syslog":
            owner   => root,
            group   => root,
            mode    => 644,
            source  => "puppet:///modules/server/syslog.logrotate",
            require => Package['logrotate'],
    }

    file { "/etc/logrotate.d/nds":
            owner   => root,
            group   => root,
            mode    => 644,
            source  => "puppet:///modules/server/nds.logrotate",
            require => Package['logrotate'],
    }

    file { "/etc/logrotate.d/misc":
            owner   => root,
            group   => root,
            mode    => 644,
            source  => "puppet:///modules/server/misc.logrotate",
            require => Package['logrotate'],
    }
}

class server::var_log_nds_cleanup {
    ### Remove logs under /var/log/nds that are more than 14 days old
    cron { "var_log_nds_cleanup":
        ensure  => present,
        command => '[ -d /var/log/nds ] && find /var/log/nds -type f -mtime +14 -exec rm -f {} \; 2>&1 >/dev/null',
        user    => "root",
        hour    => 0,
        minute  => 0,
    }
}

class server::tools {
    include server::limits
    include server::sysctl
    include server::timezone
    include server::facts::info

    $datacenter        = $datacenter        ? { undef => "ash1",    default => $datacenter }
    $host_role         = $host_role         ? { undef => "unknown", default => $host_role }
    $host_environment  = $host_environment  ? { undef => "unknown", default => $host_environment }

    case $operatingsystem {
        /^CentOS$/: {
            ### This should be installed via Kickstart
            #package { redhat-lsb: ensure => latest, require => Yumrepo["sym-base"] }
            include server::rclocal
            include server::var_log_nds_cleanup
            include server::logrotate
        }
        /^RedHat$/: {
            package { redhat-lsb: ensure => latest }
            include server::rclocal
            include server::var_log_nds_cleanup
            include server::logrotate
        }
        /[Uu]buntu/: {
            include server::ubuntu::ssd_fix
        }
    }

    case $manufacturer {
        ### Only run on Dell hardware
        'Dell Inc.': {
            package { srvadmin-base:            ensure => latest, require => Yumrepo["sym-dell"] }
            package { srvadmin-storageservices: ensure => latest, require => Yumrepo["sym-dell"] }
            package { firmware-tools:           ensure => latest, require => Yumrepo["sym-dell"] }
            package { dell_ft_install:          ensure => latest, require => Yumrepo["sym-dell"] }
            package { srvadmin-omcommon:        ensure => latest, require => Yumrepo["sym-dell"] }
            package { srvadmin-deng-snmp:       ensure => latest, require => Yumrepo["sym-dell"] }
            package { srvadmin-idrac:           ensure => latest, require => Yumrepo["sym-dell"] }

            service { "instsvcdrv":
                ensure      => running,
                enable      => true,
                hasrestart  => true,
                hasstatus   => true,
                require => Package["srvadmin-base"],
            }

            service { "dataeng":
                ensure      => running,
                enable      => true,
                hasrestart  => true,
                hasstatus   => true,
                require => Package["srvadmin-base"],
            }

            service { "dsm_om_shrsvc":
                ensure      => running,
                enable      => true,
                hasrestart  => true,
                hasstatus   => true,
                require     => Package["srvadmin-base"],
            }

            file { "/opt/dell/srvadmin/var/lib/srvadmin-deng/dcsnmp.off":
                ensure        => absent,
                notify        => Service["dataeng"],
            }

            file { "/opt/dell/srvadmin/etc/openmanage/wwwroot/oem/data/ini/placeholder.ini":
                ensure        => present,
                content       => '',
                notify        => Service["dataeng"],
            }

            file { "/etc/sysconfig/modules/ipmi.modules":
                owner   => root,
                group   => root,
                mode    => 755,
                source  => "puppet:///modules/server/ipmi.modules",
                require => Package['srvadmin-base'],
            }

            augeas {  "install.ini":
                lens          => "Puppet.lns",
                incl          => "/opt/dell/srvadmin/etc/srvadmin-omilcore/install.ini",
                changes => [
                    "set installed/SNMP enable",
                ],
                require       => Package["srvadmin-base"],
                notify        => Service["dataeng"],
            }

            cron { "omconfig_lcd_panel":
                ensure  => present,
                command => "/opt/dell/srvadmin/bin/omconfig chassis frontpanel lcdindex=1 config=custom text=$hostname.$datacenter > /dev/null 2>&1",
                user    => "root",
                hour    => '*/6',
                minute  => '1',
                require => Service["dsm_om_shrsvc"],
            }
        }

        ### VMWare VM Hardware
        'VMWare, Inc.': {
            package { 'open-vm-tools': ensure => latest }

            service { "vmtoolsd":
                ensure      => running,
                enable      => true,
                hasrestart  => true,
                hasstatus   => true,
                require     => Package["open-vm-tools"],
            }
        }

        ### Xen ###
        'Xen': {
            if $lsbmajdistrelease =~ /^6/ {
                package { xe-guest-utilities: ensure => latest }
                package { xe-guest-utilities-xenstore: ensure => latest }
            }
            package { cpuspeed: ensure => absent }
        }
    }
    
    #big data XFS support
    package { xfsdump: ensure => latest; }
    package { xfsprogs: ensure => latest; }

}

# EOF
