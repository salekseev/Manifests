class hadoop::mapreduce (
){
    service { 'mapreduce':
        ensure => running,
        enable => true,
        #path => '/usr/lib/hadoop/bin/',
        provider => 'base',
        require => Package['hadoop'],
        #subscribe => File['/etc/hadoop/conf/hdfs-format.sh'],
        start => "hadoop fs -chown -R mapred /mapred"
    }

}
