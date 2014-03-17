# /etc/puppet/resolvconf/manifests/init.pp

class resolvconf {

    $datacenter = $datacenter ? { undef => "ash1", default => $datacenter }

    if $network_eth0 =~ /^10\.(117|125|177)\.20\.0/ {
        $loc = "$datacenter.lb"
    } else {
        $loc = $datacenter
    }

    ### Do not apply this to a nameserver
    if $hostname !~ /^(ns[0-9]|infp-dns)/ {
        file { "/etc/resolv.conf":
            owner   => root,
            group   => root,
            mode    => 644,
            source  => "puppet:///modules/resolvconf/resolv.conf-$loc",
        }

        file { "/etc/gai.conf":
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => 'puppet:///modules/resolvconf/gai.conf',
        }
    }

    #case $operatingsystem {
    #    /^CentOS|RedHat$/: {
    #        augeas { "ifcfg-eth4":
    #            require => Package["ruby-augeas"],
    #            context => "/files/etc/sysconfig/network-scripts/ifcfg-eth4",
    #            changes => [
    #                "rm DNS1",
    #                "rm DNS2",
    #                "rm DNS3",
    #                "rm DNS4",
    #            ],
    #        }
    #    }
    #}
}
