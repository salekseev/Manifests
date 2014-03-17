class nagios::client {

    package { opsview-agent: ensure => latest }

    file { "/usr/local/nagios/etc/nrpe.cfg":
            owner => nagios,
            group => nagios,
            mode  => 550,
            source => "puppet:///modules/nagios/nrpe.cfg",
            require => Package['opsview-agent'],
#	    notify => Service[opsviewagent]

    }
    file { "/usr/local/nagios/libexec/check_rabbitmq_queue_length":
            owner => nagios,
            group => nagios,
            mode  => 550,
            source => "puppet:///modules/nagios/check_rabbitmq_queue_length",
            require => Package['opsview-agent'],
#	    notify => Service[opsviewagent]
   }

}
