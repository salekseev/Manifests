class hadoop (

    $FS_CHECKPOINT_DIR = '/hdfs/snn/',
    $NAMENODE_HOSTNAME = 'pbdnnash10001',
    $SECONDARYNAMENODE_HOSTNAME = 'npbddnash10001',
    $DFS_DATA_DIR = '/hdfs/dn/',
    $DFS_NAME_DIR = '/hdfs/nn/',
    $JTNODE_HOSTNAME = 'pbdnnash10001',
    $MAPRED_LOCAL_DIR = '/hdfs/mapred/',
    $MASTERS_LIST = 'pbdnnash10001
pbddnash10001',
    $SLAVES_LIST = 'pbdnnash10001
pbddnash10001
pbddnash10002
pbddnash10003',

){

# create a simple hostname and ip host entry
    host { 'pbdnnash10001':
    	ip => '10.119.134.76',
    }

    host { 'pbddnash10001':
        ip => '10.119.134.77',
    }

    host { 'pbddnash10002':
        ip => '10.119.134.78',
    }

    host { 'pbddnash10003':
        ip => '10.119.134.79',
    }

    exec { '/usr/bin/yum clean all && yum clean metadata && yum clean dbcache && yum makecache && yum update -y': }

    package { hadoop: 
	ensure => latest,
	provider => 'yum',
	name    =>  'hadoop',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
   }
    package { hadoop-libhdfs: 
	ensure => latest,
	provider => 'yum',
	name    =>  'hadoop-libhdfs',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
   }
    package { hadoop-native: 
	ensure => latest,
	provider => 'yum', 
	name    =>  'hadoop-native',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }
    package { hadoop-pipes: 
	ensure => latest,
	provider => 'yum',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }
    package { hadoop-sbin: 
	ensure => latest,
	provider => 'yum',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }
    package { openssl: 
	ensure => installed,
	provider => 'yum',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }
    #package { hadoop-docs: ensure => installed }
    package { hadoop-source: 
	ensure => latest,
	provider => 'yum',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }
    package { snappy: 
	ensure => latest,
	provider => 'yum', 
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }
    package { snappy-devel: 
	ensure => latest,
	provider => 'yum',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }
    package { hadoop-lzo: 
 	ensure => latest,
	provider => 'yum',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }
    package { lzo: 
	ensure => latest,
	provider => 'yum',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }
    package { lzo-devel: 
	ensure => latest,
	provider => 'yum', 
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }
    package { hadoop-lzo-native: 
	ensure => latest,
 	provider => 'yum',
	require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
    }


#Install Oricle Java
    exec {"jdk_install": 
        cwd     =>  "/opt/jdk", 
	path => "/opt/jdk",
        command =>  "/bin/su hdfs -c '/opt/jdk/jdk-6u31-linux-x64.bin'", 
        creates =>  "/usr/java/jdk1.6.0_31/bin/javac", 
        require =>  file["/opt/jdk/jdk-6u31-linux-x64.bin"], 
    } 

    file { "/opt/jdk/":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 755,
    }

    file {"/opt/jdk/jdk-6u31-linux-x64.bin": 
        ensure => present, 
        owner => 'hdfs',
	mode   => 750,
        source => "puppet:///modules/hadoop/jdk-6u31-linux-x64.bin"; 
    } 

   file { "/usr/java":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 775,
    }

    file { '/usr/java/default':
                ensure => 'link',
                target => '/opt/jdk/jdk1.6.0_31/',
    }

    file { '/usr/bin/java':
                ensure => 'link',
                target => '/opt/jdk/jdk1.6.0_31/bin/java',
    }


# End Oricle Java Install

    file { '/usr/lib64/libsnappy.so':
                ensure => 'link',
                mode => '755',
                target => '/usr/lib/hadoop/lib/native/Linux-amd64-64/.',
    }


#    file { '/usr/lib/hadoop/lib/native/Linux-amd64-64/.':
#   		ensure => 'link',
#	        mode => '755',
#   		target => '/usr/lib64/libsnappy.so',
#    }

   file { "/hdfs":
        	ensure => "directory",
                recurse => true,
    		owner  => "hdfs",
    		group  => "hadoop",
    		mode   => 750,
    }

    file { "/hdfs/nn":
                ensure => "directory",
                recurse => true,
		owner  => "hdfs",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/hdfs/dn":
                ensure => "directory",
                recurse => true,
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 750,
    }

    file { "/hdfs/snn":
                ensure => "directory",
                recurse => true,
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/hdfs/mapred":
                ensure => "directory",
                recurse => true,
                owner  => "mapred",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/var/log/hadoop":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/var/log/hadoop/hdfs":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/var/log/hadoop/mapred":
                ensure => "directory",
                owner  => "mapred",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/var/log/zookeeper":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 750,
    }

    file { "/var/run/hadoop/":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/var/run/hadoop/hdfs":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/var/run/hadoop/mapred":
                ensure => "directory",
                owner  => "mapred",
                group  => "hadoop",
                mode   => 755,
    }

    file { "/var/run/zookeeper":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 755,
    }


    file { "/etc/hadoop":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 750,
    }    

    file { "/etc/hadoop/conf":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 750,
    }


    file { "/etc/profile.d/directories.sh":
  		ensure => present,
  		source => "puppet:///modules/hadoop/directories.sh",
  		owner => "root",
  		group => "root",
  		mode => 644,
#  require => File[$jruby_home]
    }

   file { "/etc/profile.d/usersAndGroups.sh":
                ensure => present,
                source => "puppet:///modules/hadoop/usersAndGroups.sh",
                owner => "root",
                group => "root",
                mode => 644,
#  require => File[$jruby_home]
    }

    file { '/etc/hadoop/conf/core-site.xml':
	ensure => file,
	mode => '755',
	content => template('hadoop/core-site.xml.erb'),
    }

    file { '/etc/hadoop/conf/hdfs-site.xml':
        ensure => file,
	mode => '755',
        content => template('hadoop/hdfs-site.xml.erb'),
    }

    file { '/etc/hadoop/conf/mapred-site.xml':
        ensure => file,
	mode => '755',
        content => template('hadoop/mapred-site.xml.erb'),
    }

    file { '/etc/hadoop/conf/taskcontroller.cfg':
        ensure => file,
	mode => '755',
        content => template('hadoop/taskcontroller.cfg.erb'),
    }

    file { '/etc/hadoop/conf/masters':
        ensure => file,
	mode => '755',
        content => $MASTERS_LIST,
    }

    file { '/etc/hadoop/conf/slaves':
        ensure => file,
	mode => '755',
        content => $SLAVES_LIST,
    }

    file { '/etc/hadoop/conf/capacity-scheduler.xml':
        ensure => file,
	mode => '755',
        source => 'puppet:///modules/hadoop/capacity-scheduler.xml',
    }

    file { '/etc/hadoop/conf/commons-logging.properties':
        ensure => file,
	mode => '755',
        source => 'puppet:///modules/hadoop/commons-logging.properties',
    }

    file { '/etc/hadoop/conf/hadoop-env.sh':
        ensure => file,
	mode => '755',
        source => 'puppet:///modules/hadoop/hadoop-env.sh',
    }

    file { '/etc/hadoop/conf/hadoop-metrics2.properties':
        ensure => file,
	mode => '755',
        source => 'puppet:///modules/hadoop/hadoop-metrics2.properties',
    }
 
    file { '/etc/hadoop/conf/hadoop-metrics2.properties-GANGLIA':
        ensure => file,
	mode => '755',
        source => 'puppet:///modules/hadoop/hadoop-metrics2.properties-GANGLIA',
    }

    file { '/etc/hadoop/conf/hadoop-policy.xml':
        ensure => file,
	mode => '755',
        source => 'puppet:///modules/hadoop/hadoop-policy.xml',
    }

    file { '/etc/hadoop/conf/health_check':
        ensure => file,
	mode => '755',
        source => 'puppet:///modules/hadoop/health_check',
    }

    file { '/etc/hadoop/conf/mapred-queue-acls.xml':
        ensure => file,
	mode => '755',
        source => 'puppet:///modules/hadoop/mapred-queue-acls.xml',
    }

    ssh_authorized_key { "root@$NAMENODE_HOSTNAME":
        name   => "root@$NAMENODE_HOSTNAME",
        user   => root,
        ensure => "present",
        type   => "ssh-rsa",
        key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAyYXisBsbjPCAwPmzau18iGCU6e/d3OhNwQ+HowXB0BcSRE6yGf/vE6+i9WD5Hm9XNahwTpOgTku9PPGVtaYrDU++Iy0w29V7LnF4ffP62uVxcq+G+vxsAi1SyGBgXIH7oJulHys3aKr+uQxyLsan2K2+u17h58gYttF+G7BgmAd7eecteBOvvRMCxs9ImFF8Fkaqk8+TV+StKHjM8Ssp1R8j0HJJ4lMjvtCsQRIkd7fgzaCbGahUJ6DN2/tm2hPuUZ7Zv1xme3UG162//gRGjhuH+Qvxc5V9QFPZAcsdXMYHTkQu0oXYDpI2fVq4gxuswJxKR81/MLcRjMlcMoi9+w==',
    }

    ssh_authorized_key { "hdfs@$NAMENODE_HOSTNAME":
        name   => "hdfs@$NAMENODE_HOSTNAME",
        user   => hdfs,
        ensure => "present",
        type   => "ssh-rsa",
        key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAyYXisBsbjPCAwPmzau18iGCU6e/d3OhNwQ+HowXB0BcSRE6yGf/vE6+i9WD5Hm9XNahwTpOgTku9PPGVtaYrDU++Iy0w29V7LnF4ffP62uVxcq+G+vxsAi1SyGBgXIH7oJulHys3aKr+uQxyLsan2K2+u17h58gYttF+G7BgmAd7eecteBOvvRMCxs9ImFF8Fkaqk8+TV+StKHjM8Ssp1R8j0HJJ4lMjvtCsQRIkd7fgzaCbGahUJ6DN2/tm2hPuUZ7Zv1xme3UG162//gRGjhuH+Qvxc5V9QFPZAcsdXMYHTkQu0oXYDpI2fVq4gxuswJxKR81/MLcRjMlcMoi9+w==',
    }


}
