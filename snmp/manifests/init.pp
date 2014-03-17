# /etc/puppet/modules/snmp/manifests/init.pp

class snmp {

    case $operatingsystem {
        /^CentOS|RedHat$/: {
            package { net-snmp: ensure => latest }

            file { "/etc/snmp/snmpd.conf":
                owner        => root,
                group        => root,
                mode         => 640,
                checksum     => md5,
                content      => template( "snmp/snmpd.conf.erb" ),
                require      => Package["net-snmp"]
            }

            file { "/etc/sysconfig/snmpd.options":
                owner        => root,
                group        => root,
                mode         => 640,
                source       => "puppet:///modules/snmp/snmpd.options",
                require      => Package["net-snmp"],
            }

            file { "/etc/sysconfig/snmpd":
                owner        => root,
                group        => root,
                mode         => 640,
                source       => "puppet:///modules/snmp/snmpd",
                require      => Package["net-snmp"],
            }

            service { "snmpd":
                ensure       => running,
                enable       => true,
                subscribe    => [ File["/etc/snmp/snmpd.conf"], File["/etc/sysconfig/snmpd.options"] ]
            }
        }
        /[Uu]buntu/: {
            package { snmpd: ensure => latest }

            file { "/etc/snmp/snmpd.conf":
                owner        => root,
                group        => root,
                mode         => 640,
                checksum     => md5,
                content      => template( "snmp/snmpd.conf.erb" ),
                require      => Package["net-snmp"]
             }

            service { "snmpd":
                ensure       => running,
                enable       => true,
                subscribe    => [ File["/etc/snmp/snmpd.conf"] ]
            }
        }
    }

}

