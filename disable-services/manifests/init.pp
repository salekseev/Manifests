# /etc/puppet/postfix/manifests/init.pp

class disable-services {
    service { avahi-daemon: ensure => stopped, enable => false }
    service { bluetooth: ensure    => stopped, enable => false }
    service { cups: ensure         => stopped, enable => false }
    service { gpm: ensure          => stopped, enable => false }
    service { iscsi: ensure        => stopped, enable => false }
    service { iscsid: ensure       => stopped, enable => false }
    service { lvm2-monitor: ensure => stopped, enable => false }
    service { mcstrans: ensure     => stopped, enable => false }
    service { pcscd: ensure        => stopped, enable => false }
    service { restorecond: ensure  => stopped, enable => false }
    service { rpcgssd: ensure      => stopped, enable => false }
    service { rpcidmapd: ensure    => stopped, enable => false }
    service { yum-updatesd: ensure => stopped, enable => false }

    package { logwatch: ensure     => absent }

    ### Disable until we set the gov to high performance
    ### XXX: TESTME
    case $is_virtual {
        /false/ : {
            service { cpuspeed: ensure => stopped,     enable => false }
        }
    }

    case $fqdn {
        /infa-png/             : {
            service { iptables: ensure => stopped,     enable => false }
        }
        default                : {
            service { ip6tables: ensure => stopped,    enable => false }
            service { iptables: ensure => stopped,     enable => false }
        }
    }
}

