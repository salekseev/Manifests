class hdp::mysql(
  $ensure = 'present',
  $time = ['23', '5'],
 )
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
	
   file { "/etc/my.cnf":
                ensure => present,
                source => "puppet:///modules/hdp/my.cnf",
                owner => "root",
                group => "root",
                mode => 644,
                require => Package['mysql-server'],
    }
   
   file { "/tmp/mysql-serversetup.sh":
                ensure => present,
                source => "puppet:///modules/hdp/mysql-serversetup.sh",
                owner => "root",
                group => "root",
                mode => 774,
		require => [File['/etc/my.cnf'],Package['mysql-server']],
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
       		require => [File['/tmp/setuphiveusers.sql'],File['/tmp/setupoozieusers.sql'],File['/tmp/mysql-serversetup.sh']],
        	path    => "/tmp",
		creates => '/tmp/mysql-server-setup.pid',
    		logoutput => true,
	} 
    
   cron { 'mysql-backup':
    		ensure  => $ensure,
    		command => '/usr/local/sbin/mysqlbackup.sh',
    		user    => 'root',
    		hour    => $time[0],
    		minute  => $time[1],
    		require => File['mysqlbackup.sh'],
  	}

   file { 'mysqlbackup.sh':
    		ensure  => $ensure,
    		path    => '/usr/local/sbin/mysqlbackup.sh',
    		mode    => '0700',
    		owner   => 'root',
    		group   => 'root',
    		content => template('hdp/mysqlbackup.sh.erb'),
  	} 
}
