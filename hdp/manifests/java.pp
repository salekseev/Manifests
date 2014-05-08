class hdp::java()
{

   package { 'jdk':
	ensure => latest,
	provider => 'yum',
	name    =>  'jdk',
    }
    
    exec {"Install Alternatives java":
	command => "/usr/sbin/alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_51/bin/java 500000",
	require => Package['jdk'],
	logoutput => true,
   }
    
    exec {"Install Alternatives javaw":
        command => "/usr/sbin/alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.7.0_51/jre/bin/javaws 500000",
	require => Package['jdk'],
	logoutput => true,
   }    

}
