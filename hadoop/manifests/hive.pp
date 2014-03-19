class hadoop::hive()
{

    package { hive:
        ensure => latest,
        provider => 'yum',
        name    =>  'hive',
        require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
   }

    package { hcatalog:
        ensure => latest,
        provider => 'yum',
        name    =>  'hcatalog',
        require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
   }

   package { 'mysql-connector-java':
        ensure => latest,
        provider => 'yum',
        name    =>  'mysql-connector-java',
        #require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
   }

    file {"/usr/lib/hive/lib/mysql-connector-java-5.1.17.jar":
        ensure => present,
        owner => 'hive',
        mode   => 750,
        source => "puppet:///modules/hadoop/mysql-connector-java-5.1.17.jar";
    }

    file { '/etc/hive/conf/hive-env.sh':
        ensure => file,
        mode => '755',
        content => template('hadoop/hive-env.sh.erb'),
    }

    file { '/etc/hive/conf/hive-site.xml':
        ensure => file,
        mode => '755',
        content => template('hadoop/hive-site.xml.erb'),
    }

    file { '/etc/hive/conf/hive-site.xml.default':
        ensure => file,
        mode => '755',
        content => template('hadoop/hive-site.xml.default.erb'),
    }

    file { '/etc/hive/conf/hive-site.xml.orig':
        ensure => file,
        mode => '755',
        content => template('hadoop/hive-site.xml.orig.erb'),
    }

    file { "/var/log/hive":
                ensure => "directory",
                owner  => "hive",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/etc/hive":
                ensure => "directory",
                owner  => "hive",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/etc/hive/conf":
                ensure => "directory",
                owner  => "hive",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/usr/lib/hive":
                ensure => "directory",
                owner  => "hive",
                group  => "hadoop",
		recurse => true,
                mode   => 755,
    }

    file { "/home/hive":
                ensure => "directory",
                owner  => "hive",
                group  => "hadoop",
                mode   => 755,
    }

    exec { "hive-mkdir":
        command => '/usr/bin/hadoop fs -mkdir /user/hive',
        #require => File['/var/run/hadoop/hdfs/hdfs-format.pid'],
        path    => "/usr/bin/:/bin/",
    }

    exec { "hive-chown":
        command => '/usr/bin/hadoop fs -chown hive:hive /user/hive',
        require => Exec['hive-mkdir'],
        path    => "/usr/bin/:/bin/",
    }

    exec { "warehouse-mkdir":
        command => "/usr/bin/hadoop fs -mkdir /apps/hive/warehouse",
        require => Exec['hive-mkdir'],
         path    => "/usr/bin/:/bin/",  
    }


    exec { "warehouse-chown":
        command => '/usr/bin/hadoop fs -chown -R hive:users /apps/hive/warehouse',
        require => Exec['warehouse-mkdir'],
        path    => "/usr/bin/:/bin/",  
    }

    exec { "warehouse-chmod":
        command => '/usr/bin/hadoop fs -chmod -R 775 /apps/hive/warehouse',
        require => Exec['warehouse-mkdir'],
        path    => "/usr/bin/:/bin/", 
    }

    exec { "scratch-mkdir":
        command => "/usr/bin/hadoop fs -mkdir -p /tmp/scratch",
       # require => Exec['hive-mkdir'],
         path    => "/usr/bin/:/bin/",
    }


    exec { "scratch-chown":
        command => '/usr/bin/hadoop fs -chown -R hive:users /tmp/scratch',
        require => Exec['scratch-mkdir'],
        path    => "/usr/bin/:/bin/",
    }

    exec { "scratch-chmod":
        command => '/usr/bin/hadoop fs -chmod -R 777 /tmp/scratch',
        require => Exec['scratch-mkdir'],
        path    => "/usr/bin/:/bin/",
    }

    exec { "hive":
        command => "su hive -c 'nohup hive --service metastore > /var/log/hive/hive.out 2> /var/log/hive/hive.log &'",
        #require => Exec['warehouse-mkdir'],
        path    => "/usr/bin/:/bin/",
    }


    exec { "hive2":
        command => "su hive -c '/usr/lib/hive/bin/hiveserver2 >/var/log/hive/hiveserver2.out 2> /var/log/hive/hiveserver2.log &'",
        #require => Exec['warehouse-mkdir'],
        path    => "/usr/bin/:/bin/",
    }
#    service { 'secondarynamenode':
#        ensure => running,
#        enable => true,
#        path => '/usr/lib/hadoop/bin/',
#        provider => 'base',
#        require => Package['hadoop'],
#        #subscribe => File['/etc/hadoop/conf/hdfs-format.sh'],
#        start => "runuser -l hdfs -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /etc/hadoop/conf start secondarynamenode'"

}
