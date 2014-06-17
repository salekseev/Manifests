class hdp::ambariinstallcluster()
{

include hdp::params
require hdp::yum
require hdp::java
require hdp::ambariagent
require hdp::mysql
require hdp::ambariserver

   file { '/etc/ambari-server/conf/ambari-clustertemplate.conf.singlemaster':
        ensure => file,
        mode => '755',
        content => template('hdp/ambari-clustertemplate.conf.singlemaster.erb'),
	require => Class["hdp::ambariserver"],
    }

   file { '/etc/ambari-server/conf/ambari-blueprint.conf.singlemaster':
        ensure => file,
        mode => '755',
        content => template('hdp/ambari-blueprint.conf.singlemaster.erb'),
	require => Class["hdp::ambariserver"],
    }


   file { '/etc/ambari-server/conf/ambari-blueprint-prod.conf':
        ensure => file,
        mode => '755',
        content => template('hdp/ambari-blueprint-prod.conf.erb'),
        require => Class["hdp::ambariserver"],
    }

   file { '/etc/ambari-server/conf/ambari-clustertemplate-cpe.conf':
        ensure => file,
        mode => '755',
        content => template('hdp/ambari-clustertemplate-cpe.conf.erb'),
        require => Class["hdp::ambariserver"],
    }

  file{"/tmp/check_status.py":
    source => "puppet:///modules/hdp/check_status.py",
    require => Class["hdp::ambariserver"],
  }

  file{"/tmp/check_status.sh":
    content => template('hdp/check_status.sh.erb'),
    require => Class["hdp::ambariserver"],
  }
  
 file {"/tmp/check-ambari-hosts.sh":
    content => template('hdp/check-ambari-hosts.sh.erb'),
    require => Class["hdp::ambariserver"],
  }

  exec {"wait for ambari register hosts":
    require => [Service['ambari-server'],File["/tmp/check-ambari-hosts.sh"],Class["hdp::ambariserver"],Class["hdp::ambariagent"]],
    command => "/bin/bash /tmp/check-ambari-hosts.sh",
    logoutput => true, 
    creates => '/tmp/ambari-check-ambariagent-register.pid', 
   }

 file {"/tmp/cluster_blueprint.py":
    source => "puppet:///modules/hdp/cluster_blueprint.py",
    mode => '755',
    ensure => file,
    require => Class["hdp::ambariserver"],
  }

 file { '/tmp/ambari-install-cluster.sh':
       ensure => file,
       mode => '755',
       content => template('hdp/ambari-install-cluster.sh.erb'),
       require => Class["hdp::ambariserver"],
    }

 exec {"install cluster":
    command => "/tmp/ambari-install-cluster.sh",
    require => [File["/tmp/cluster_blueprint.py"],File["/etc/ambari-server/conf/ambari-blueprint.conf.singlemaster"],Class["hdp::ambariserver"],Exec["wait for ambari register hosts"]],
    logoutput => true,
    creates => '/tmp/ambari-install-cluster.pid',
  }

}
