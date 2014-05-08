class hdp::mysql()
{
   include hdp::params
   require hdp::yum
   require hdp::java
 
   package { 'mysql-server':
        ensure => latest,
        provider => 'yum',
        name    =>  'mysql-server',
    }
    
   package { 'mysql':
        ensure => latest,
        provider => 'yum',
        name    =>  'mysql',
    }
   
   file { "/tmp/mysql-serversetup.sh":
                ensure => present,
                source => "puppet:///modules/hdp/mysql-serversetup.sh",
                owner => "root",
                group => "root",
                mode => 774,
		require => Package['mysql-server'],
    }
    
    file { "/tmp/setuphiveusers.sql":
                ensure => present,
                content => template('hdp/setuphiveusers.sql.erb'),
                owner => "root",
                group => "root",
                mode => 774,
		require => [Package['mysql-server'],File[ '/tmp/mysql-serversetup.sh']],
    }
    
   file { "/tmp/setupoozieusers.sql":
                ensure => present,
                content => template('hdp/setupoozieusers.sql.erb'),
                owner => "root",
                group => "root",
                mode => 774,
                require => [Package['mysql-server'],File[ '/tmp/mysql-serversetup.sh']],
    }   

    exec { "mysql-serversetup.sh":
 	        command => "/tmp/mysql-serversetup.sh",
       		require => File['/tmp/mysql-serversetup.sh'],
        	path    => "/tmp",
    		logoutput => true,
	} 
   
}
