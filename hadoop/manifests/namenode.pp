class hadoop::namenode (
){

    file { "/home/mapred/":
                ensure => "directory",
                owner  => "mapred",
                group  => "hadoop",
                mode   => 750,
    }

    file { "/home/hdfs/.ssh/":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 750,
    }

    file { "/home/mapred/.ssh":
                ensure => "directory",
                owner  => "mapred",
                group  => "hadoop",
                mode   => 750,
    }

    file { '/root/.ssh/id_rsa':
        ensure => file,
        mode => '600',
	owner => "root",
	group => "root",
        source => 'puppet:///modules/hadoop/id_rsa',
    }

    file { '/root/.ssh/id_rsa.pub':
        ensure => file,
        mode => '644',
	owner => "root",
	group => "root",
        source => 'puppet:///modules/hadoop/id_rsa.pub',
    }

    file { '/home/mapred/.ssh/id_rsa':
        ensure => file,
        mode => '600',
        owner => "mapred",
        group => "mapred",
        source => 'puppet:///modules/hadoop/id_rsa',
    }

    file { '/home/mapred/.ssh/id_rsa.pub':
        ensure => file,
        mode => '644',
        owner => "mapred",
        group => "mapred",
        source => 'puppet:///modules/hadoop/id_rsa.pub',
    }

    file { '/home/hdfs/.ssh/id_rsa':
        ensure => file,
        mode => '600', 
        owner => "hdfs",
        group => "hdfs",
        source => 'puppet:///modules/hadoop/id_rsa',
    }   
        
    file { '/home/hdfs/.ssh/id_rsa.pub':
        ensure => file,
        mode => '644',
        owner => "hdfs",
        group => "hdfs",
        source => 'puppet:///modules/hadoop/id_rsa.pub',
    }

    ssh_authorized_key { "mapred@$hadoop::NAMENODE_HOSTNAME":
        name   => "mapred@$hadoop::NAMENODE_HOSTNAME",
        user   => root,
        ensure => "present",
        type   => "ssh-rsa",
        key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAyYXisBsbjPCAwPmzau18iGCU6e/d3OhNwQ+HowXB0BcSRE6yGf/vE6+i9WD5Hm9XNahwTpOgTku9PPGVtaYrDU++Iy0w29V7LnF4ffP62uVxcq+G+vxsAi1SyGBgXIH7oJulHys3aKr+uQxyLsan2K2+u17h58gYttF+G7BgmAd7eecteBOvvRMCxs9ImFF8Fkaqk8+TV+StKHjM8Ssp1R8j0HJJ4lMjvtCsQRIkd7fgzaCbGahUJ6DN2/tm2hPuUZ7Zv1xme3UG162//gRGjhuH+Qvxc5V9QFPZAcsdXMYHTkQu0oXYDpI2fVq4gxuswJxKR81/MLcRjMlcMoi9+w==',
    }


    file { "/etc/hadoop/conf/hdfs-format.sh":
                ensure => present,
                source => "puppet:///modules/hadoop/hdfs-format.sh",
                owner => "root",
                group => "root",
                mode => 774,
#  require => File[$jruby_home]
    }


    exec { "hdfs-format":
    	command => "/etc/hadoop/conf/hdfs-format.sh",
    	require => File['/etc/hadoop/conf/hdfs-format.sh'],
	# path    => [ "/usr/local/bin/", "/bin/" ],  # alternative syntax
    }

    exec { "mapred-mkdir":
        command => '/usr/bin/hadoop fs -mkdir /mapred',
        #require => File['/var/run/hadoop/hdfs/hdfs-format.pid'],
        path    => "/usr/bin/:/bin/",  # alternative syntax
    }

    exec { "mapred-chown":
        command => '/usr/bin/hadoop fs -chown -R mapred /mapred',
        require => Exec['mapred-mkdir'],
        path    => "/usr/bin/:/bin/",  # alternative syntax
    }


    service { 'namenode':
	ensure => running,
	enable => true,
	path => '/usr/lib/hadoop/bin/',
	provider => 'base',
	require => Package['hadoop'],
	subscribe => File['/etc/hadoop/conf/hdfs-format.sh'],
	start => "runuser -l hdfs -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /etc/hadoop/conf start namenode'"
    }

    service { 'jobtracker':
        ensure => running,
        enable => true,
        path => '/usr/lib/hadoop/bin/',
        provider => 'base',
        require => Package['hadoop'],
        subscribe => File['/etc/hadoop/conf/hdfs-format.sh'],
        start => "runuser -l mapred -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /etc/hadoop/conf start jobtracker'"
    }

    service { 'historyserver':
        ensure => running,
        enable => true,
        path => '/usr/lib/hadoop/bin/',
        provider => 'base',
        require => Package['hadoop'],
        subscribe => File['/etc/hadoop/conf/hdfs-format.sh'],
        start => "runuser -l mapred -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /etc/hadoop/conf start historyserver'"
    }



}
