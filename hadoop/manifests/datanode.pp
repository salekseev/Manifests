class hadoop::datanode (
){
    service { 'datanode':
        ensure => running,
        enable => true,
        path => '/usr/lib/hadoop/bin/',
        provider => 'base',
        require => Package['hadoop'],
        #subscribe => File['/etc/hadoop/conf/hdfs-format.sh'],
        start => "runuser -l hdfs -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /etc/hadoop/conf start datanode'"
    }
}
