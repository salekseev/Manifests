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
        	command => "/tmp/ambari-serversetup.sh",
		require => [File["/tmp/ambari-serversetup.sh"],Package['ambari-serverinstall']],
		logoutput => true,
		notify => Service['ambari-server'],
	}
 
#    file {"/var/lib/pgsql/data/pg_hba.conf":
 #               ensure => present,
  #              source => "puppet:///modules/hdp/pg_hba.conf",
   #             owner => "root",
    #            group => "root",
     #           mode => 744,
      #          require => [Exec["ambariserver-setup"],Package['ambari-serverinstall']],
    #}
    
   service { 'ambari-server':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require => Exec["ambariserver-setup"],	    
     }
}
