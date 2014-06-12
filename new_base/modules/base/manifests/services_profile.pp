################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

#Self contained profile - not using tech community module
class base::services_profile {
    case $::osfamily {
        "RedHat"             : {
          service { avahi-daemon: ensure => stopped, enable => false }
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
        }
        "Debian"             : {
        }
        default              : {
        }
    }

    ### Disable until we set the gov to high performance
    ### TODO: TESTME
    case $is_virtual {
        /false/ : {
            service { cpuspeed: ensure => stopped,     enable => false }
        }
    }

}
