class hadoop::pig (
){

    package { pig:
        ensure => latest,
        provider => 'yum',
        name    =>  'pig',
        require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
   }

    service { 'secondarynamenode':
        ensure => running,
        enable => true,
        path => '/usr/lib/hadoop/bin/',
        provider => 'base',
        require => Package['hadoop'],
        #subscribe => File['/etc/hadoop/conf/hdfs-format.sh'],
        start => "runuser -l hdfs -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /etc/hadoop/conf start secondarynamenode'"
    }
}
