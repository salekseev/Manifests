class hdp-util::java {

  if ! defined(Package['jdk']) {
    package { 'jdk':
      ensure   => '1.7.0_51-fcs',
      provider => 'yum',
      name     => 'jdk',
    }
  }

  if ! defined(Exec['alternatives-java']) {
    exec {'alternatives-java':
      command   => "/usr/sbin/alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_51/bin/java 200000",
      require   => Package['jdk'],
      logoutput => true,
      creates   => '/etc/alternatives/java',
    }
  }

  if ! defined(Exec[alternatives-javaws]) {
    exec {'alternatives-javaws':
      command   => "/usr/sbin/alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.7.0_51/jre/bin/javaws 200000",
      require   => Package['jdk'],
      logoutput => true,
      creates   => '/etc/alternatives/javaws',
    }    
  }
}
