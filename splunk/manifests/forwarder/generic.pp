class splunk::forwarder::generic {

    include splunk::forwarder::base

    file { "/opt/splunkforwarder/etc/system/local/outputs.conf":
            owner => 'root',
            group => 'root',
            mode  => '644',
            source => "puppet:///modules/splunk/outputs.conf",
            require => Package['splunkforwarder'],
            notify => Service['splunk'],
    }

    file { "/opt/splunkforwarder/etc/system/local/inputs.conf":
            owner => 'root',
            group => 'root',
            mode  => '644',
            source => [ "puppet:///modules/splunk/inputs.conf.${host_role}.${host_environment}", "puppet:///modules/splunk/inputs.conf.${host_environment}" ],
            require => Package['splunkforwarder'],
            notify => Service['splunk'],
    }

    service { "splunk":
            ensure    => running,
            hasstatus => true,
            enable    => true,
            require   => [Package["splunkforwarder"], File["/opt/splunkforwarder/etc/system/local/inputs.conf"], File["/opt/splunkforwarder/etc/system/local/outputs.conf"]],
    }
}
### EOF


