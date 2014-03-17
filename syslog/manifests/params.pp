### Syslog defaults
class syslog::params {
    $syslog_package   = 'rsyslog'
    $syslog_service   = 'rsyslog'
    $syslog_version   = 'latest'
    $syslog_conf_path = '/etc/rsyslog.conf'
    $syslog_template  = 'rsyslog/rsyslog.conf.erb'
    $syslog_template  = $syslog::params::syslog_template
}

### EOF
