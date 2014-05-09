class hdp (
$role = $::role,
)
{
include hdp::params

#######stop iptables################

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


file { "/var/lib/jenkins":
	ensure => directory,
	recurse => true
}
file { "/var/lib/jenkins/cluster-info.py":
	ensure => present,
	source => "puppet:///modules/hdp/cluster-info.py",
	owner => "jenkins",
	#group => "jenkins",
	mode => 774,
	require => File['/var/lib/jenkins']
}


Exec { path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/", "/usr/local/bin" ] }

case $role { 
   
   'ambari-server':{
	require hdp::ambariinstallcluster	
    }
   
   'ambari-agent':{
	require hdp::ambariagent	
    }
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

