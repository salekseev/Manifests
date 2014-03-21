class hadoop::tasktrackernode (
){
    service { 'tasktracker':
        ensure => running,
        enable => true,
        path => '/usr/lib/hadoop/bin/',
        provider => 'base',
        require => Package['hadoop'],
        start => "runuser -l mapred -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /etc/hadoop/conf start tasktracker'"
    }
}
