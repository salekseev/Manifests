class splunk::forwarder::base {

    case $operatingsystem {
        /^CentOS|RedHat$/: {
            package { "splunkforwarder": ensure => latest, require => File["/etc/login.defs"] }
        }
        /^Ubuntu/: {
            package { "splunkforwarder": ensure => latest }
        }
    }

    exec { "accept_splunk_license":
            command => "/opt/splunkforwarder/bin/splunk enable boot-start --accept-license --answer-yes --no-prompt",
            path    => [ '/opt/splunkforwarder/bin', '/usr/bin', '/usr/sbin', '/sbin' ],
            subscribe => Package['splunkforwarder'],
            require => Package['splunkforwarder'],
            refreshonly => true,
    }
}

### EOF

