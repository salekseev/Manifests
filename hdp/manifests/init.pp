class hdp (
$role = $::role,
)
{
 
include hdp::params

####### stop iptables and ip6tables ################

service { 'iptables':
        ensure => stopped,
        enable => false,
        path => '/etc/init.d/',
    }

service { 'ip6tables':
        ensure => stopped,
        enable => false,
        path => '/etc/init.d/',
    }

###### installing cluster-info.py in bdcp node #############

file { "/var/lib/jenkins":
	ensure => directory,
	recurse => true
    }

file { "/var/lib/jenkins/cluster-info.py":
	ensure => present,
	source => "puppet:///modules/hdp/cluster-info.py",
#	content => template('hdp/cluster-info.py.erb'),
	owner => "jenkins",
	mode => 774,
	require => File['/var/lib/jenkins']
    }

Exec { path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/", "/usr/local/bin" ] }

case $role { 

   # Role defined for DAO ambari-server   

   'ambari-server':{
	require hdp::ambariinstallcluster	
    }
   
   # Role defined for DAO ambari-agent
   
   'ambari-agent':{
	require hdp::ambariagent	
    }
   
   # Role defined for DAO mysql server
   
   'mysql':{
    	require hdp::mysql
    } 

   # No classes should be included for this role 

   'generic':{
      notify {'I am generic node':}
      @@notify {"$fqdn collected":}
      Notify <<| |>>
    }

   # End of case statement

   }
}

