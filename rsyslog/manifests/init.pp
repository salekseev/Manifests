# /etc/puppet/rsyslog/manifests/init.pp

class rsyslog::config {
    $datacenter = $datacenter ? { undef => "ash1", default => $datacenter }

    if $datacenter == "acc4" {
        $syslog_forwarder = "10.117.6.27"
    } elsif $datacenter =~ /acc5/ {
        $syslog_forwarder = "10.177.6.27"
    } else {
        $syslog_forwarder = "10.125.6.27"
    }
}

class rsyslog::base {
    include rsyslog::config

    package { rsyslog: ensure   => present }
    package { syslog-ng: ensure => absent }

    service { "rsyslog":
        ensure    => running,
        enable    => true,
        require   => Package["rsyslog"],
        subscribe => File["/etc/rsyslog.conf"],
    }

    file { "/etc/rsyslog.d":
        ensure          => directory,
        owner           => "root",
        group           => "root",
        mode            => 0755,
    }

    file { "/var/log/nds":
        ensure          => directory,
        owner           => "root",
        group           => "root",
        mode            => 1777,
    }
}

class rsyslog::operations {
    include rsyslog::base

    if $fqdn =~ /splunk/ {
        $sourcefile = "rsyslog-splunk"
    } elsif $fqdn =~ /^qa/ {
        $sourcefile = "rsyslog-dev"
    } elsif $fqdn =~ /^dev/ {
        $sourcefile = "rsyslog-dev"
    } elsif $host_environment =~ /^qa/ {
        $sourcefile = "rsyslog-dev"
    } elsif $host_environment =~ /^dev/ {
            $sourcefile = "rsyslog-dev"
    } else {
        $sourcefile = "rsyslog"
    }

    file { "/etc/rsyslog.conf":
        owner   => root,
        group   => root,
        mode    => 0644,
        content => template("rsyslog/$sourcefile.conf.erb"),
    }
}

### Dev config, don't filter out debug logs
class rsyslog::dev {

    include rsyslog::base

    file { "/etc/rsyslog.conf":
        owner   => root,
        group   => root,
        mode    => 0644,
        content => template("rsyslog/rsyslog-dev.conf.erb"),
    }
}

### Aggregator
class rsyslog::server {

    include rsyslog::base

        file { "/etc/rsyslog.conf":
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template("rsyslog/rsyslog-server.conf.erb"),
        }

        file { "/etc/logrotate.d/rsyslog":
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => 'puppet:///rsyslog/logrotate.rsyslog',
        }

        ## Remove the secure audit logs that are more than 3 months old
        cron { "cleanup_audit_logs":
            ensure  => present,
            command => '[ -d /data/syslog/audit/secure ] && find /data/syslog/audit/secure -type f -mtime +90 -exec rm -f {} \; 2>&1 >/dev/null',
            user    => "root",
            hour    => '0',
            minute  => '0',
        }
}

### EOF
