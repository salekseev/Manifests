class hadoop::pig()
{
    package { 'pig':
        ensure => latest,
        provider => 'yum',
        name    =>  'pig',
        require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
   }

    file { '/etc/pig/conf/pig.properties':
	ensure => file,
	mode => '755',
	content => template('hadoop/pig.properties.erb'),
	require => Package['pig'],
    }

    file { '/etc/pig/conf/log4j.properties':
        ensure => file,
        mode => '755',
        content => template('hadoop/log4j.properties.erb'),
	require => Package['pig'],
    }

    file { "/etc/pig":
                ensure => "directory",
                owner  => "hdfs",
                group  => "hadoop",
                mode   => 755,
	require => Package['pig'],
    }
}
