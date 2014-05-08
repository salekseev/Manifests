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
    
#    file { '/tmp/ambari-agentstart.sh':
 #               ensure => present,
  #              source => "puppet:///modules/hdp/ambari-agentstart.sh",
   #             owner => "root",
    #            group => "root",
     #           mode => 774,
      #          require => Package['ambari-agent'],
    #}
    service { 'ambari-agent':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => File['/etc/ambari-agent/conf/ambari-agent.ini'],
    }
#     exec { "ambariagent-setup":
 #       command => "/tmp/ambari-agentstart.sh",
  #      require => File['/etc/ambari-agent/conf/ambari-agent.ini'],
#	logoutput => true,
 #   }

}
