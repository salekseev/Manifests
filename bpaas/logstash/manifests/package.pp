class logstash::package {

# copy a remote file 
file { "/tmp/logstash-1.4.0.tar.gz":
    mode   => 755,
    source => "puppet:///modules/logstash/logstash-1.4.0.tar.gz"
}

# untar the file into /opt
exec { "untar logstash":
	command => "tar xzf /tmp/logstash-1.4.0.tar.gz -C /opt",
     } 

#Create the required link

file { "/opt/logstash":
	ensure => 'link',
	target => "/opt/logstash-1.4.0",
	require => EXEC["untar logstash"],
     }
}
