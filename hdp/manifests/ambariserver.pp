class hdp::ambariserver()
{
    package { 'ambari-serverinstall':
        	ensure => latest,
        	provider => 'yum',
        	name    =>  'ambari-server',
        	require => Class["hdp::yum"],
    }

    file { "/tmp/ambari-serversetup.sh":
                ensure => present,
                source => "puppet:///modules/hdp/ambari-serversetup.sh",
                owner => "root",
                group => "root",
                mode => 774,
		require => Package['ambari-serverinstall'],
    }

    exec { "ambariserver-setup":
        	command => "/etc/init.d/ambari-server setup -s -j /usr/java/jdk1.7.0_51",
		path    => "/usr/bin/:/bin/",
		require => Package['ambari-serverinstall'],
		logoutput => true,
	}
 
   file { '/tmp/ambari-serverstart.sh':
                ensure => present,
                source => "puppet:///modules/hdp/ambari-serverstart.sh",
                owner => "root",
                group => "root",
                mode => 774,
                require => Package['ambari-serverinstall'],
    	}
   
    exec {"ambari-server start":
		command => "/tmp/ambari-serverstart.sh",
    		require => Exec['ambariserver-setup'],
    	        logoutput => true,
  	 }
   
    file {"/var/lib/pgsql/data/pg_hba.conf":
                ensure => present,
                source => "puppet:///modules/hdp/pg_hba.conf",
                owner => "root",
                group => "root",
                mode => 744,
                require => [Exec["ambari-server start"],Package['ambari-serverinstall']],
    }
    
   service { 'ambari-server':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => File["/var/lib/pgsql/data/pg_hba.conf"],
    }
}
