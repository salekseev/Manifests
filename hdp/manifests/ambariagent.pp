class hdp::ambariagent()
{
   include hdp::params
   require hdp::yum
   require hdp::java
 
   package { 'mysql-connector-java':
        ensure => latest,
        provider => 'yum',
        name    =>  'mysql-connector-java',
   }   
   
   package { 'ambari-agent':
        ensure => latest,
        provider => 'yum',
        name    =>  'ambari-agent',
    }

   package { 'libffi-devel':
        ensure => latest,
        provider => 'yum',
        name    =>  'libffi-devel',
   }
 
   package { 'python2-devel':
        ensure => latest,
        provider => 'yum',
        name    =>  'python-devel',
   }

  package { 'openssl-devel':
        ensure => latest,
        provider => 'yum',
        name    =>  'openssl-devel',
   }
 
   file { '/etc/ambari-agent/conf/ambari-agent.ini':
        ensure => file,
        mode => '755',
        content => template('hdp/ambari-agent.ini.erb'),
	require => Package['ambari-agent'],
    } 
    
   file { '/usr/lib/python2.6/site-packages/resource_management/core/providers/accounts.py':
	ensure => file,
        mode => '755',
        require => Package['ambari-agent'],
	source => "puppet:///modules/hdp/accounts.py",
    }
    
    service { 'ambari-agent':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => [File['/usr/lib/python2.6/site-packages/resource_management/core/providers/accounts.py'],File['/etc/ambari-agent/conf/ambari-agent.ini']],
    }

}
