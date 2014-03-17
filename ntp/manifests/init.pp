# /etc/puppet/ntp/manifests/init.pp

class ntp::client {

    $datacenter = $datacenter ? { undef => "ash1", default => $datacenter }

    if $network_eth0 =~ /^10\..*\.20\.0/ {
        $loc = "$datacenter.lb"
    } else {
        $loc = $datacenter
    }

    package { ntp: ensure => latest }

    $ntpservice = $operatingsystem ? {
        /(CentOS|RedHat)/ => 'ntpd',
        /(Ubuntu|Debian)/ => 'ntp',
    }

    ### Do not apply this to a nameserver
    if $hostname !~ /^ns[0-9]/ {
        file { "/etc/ntp.conf":
            owner   => root,
            group   => root,
            mode    => 644,
            source  => "puppet:///modules/ntp/ntp.conf.$loc",
            require => Package["ntp"],
            notify  => Service[$ntpservice],
        }
    }

    service { "$ntpservice": ensure => running, enable => true }
}

class ntp::server {

    package { ntp: ensure => latest }

    file { "/etc/ntp.conf":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/ntp/ntp-server.conf",
        require => Package["ntp"],
        notify  => Service["ntpd"],
    }

    service { "ntpd": ensure => running, enable => true }
}

# EOF
