class splunk::forwarder::zone {

    include splunk::forwarder::base

    if $splunk_override      =~ /^qa/  {
        $my_module = "zone_qa"
    } elsif $splunk_override =~ /^dev/ {
        $my_module = "zone_dev"
    } elsif $splunk_override =~ /^uat/ {
        $my_module = "zone_uat"
    } elsif $splunk_override =~ /^beta/ {
        $my_module = "zone_beta"
    } else {
        $name_split = split( $name, '::' )
        $my_module  = $name_split[-1]
    }

    file { "/opt/splunkforwarder/etc/system/local/outputs.conf":
            owner => root,
            group => root,
            mode  => 644,
            source => "puppet:///modules/splunk/outputs.conf",
            require => Package['splunkforwarder'],
            notify => Service['splunk'],
    }

    file { "/opt/splunkforwarder/etc/system/local/inputs.conf":
            owner => root,
            group => root,
            mode  => 644,
            source => [ "puppet:///modules/splunk/inputs.conf.$my_module.$host_environment", "puppet:///modules/splunk/inputs.conf.$my_module" ],
            require => Package['splunkforwarder'],
            notify => Service['splunk'],
    }

    service { "splunk":
            ensure    => running,
            hasstatus => true,
            enable    => true,
            require   => [Package["splunkforwarder"], File["/opt/splunkforwarder/etc/system/local/inputs.conf"]],
    }
}
### EOF


