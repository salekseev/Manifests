class hdp::ambariserver(
  $ensure = 'present',
  $time = ['23', '5'],
)
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
   
  cron { 'ambaridb-backup':
                ensure  => $ensure,
                command => '/usr/local/sbin/ambaridbbackup.sh',
                user    => 'root',
                hour    => $time[0],
                minute  => $time[1],
                require => File['ambaridbbackup.sh'],
        }

   file { 'ambaridbbackup.sh':
                ensure  => $ensure,
                path    => '/usr/local/sbin/ambaridbbackup.sh',
                mode    => '0700',
                owner   => 'root',
                group   => 'root',
                content => template('hdp/ambaridbbackup.sh.erb'),
        } 

}
