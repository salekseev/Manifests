class hdp::ambariserver()
{
    package { 'ambari-serverinstall':
        	ensure => latest,
        	provider => 'yum',
        	name    =>  'ambari-server',
        	require => [Class["hdp::java"],Class["hdp::yum"]],
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
        	command => "/tmp/ambari-serversetup.sh",
		require => [File["/tmp/ambari-serversetup.sh"],Package['ambari-serverinstall']],
		logoutput => true,
		creates => '/tmp/ambari-server-setup.pid',
		notify => Service['ambari-server'],
	}
 
   service { 'ambari-server':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => false,
      require => Exec["ambariserver-setup"],	    
     }
}
