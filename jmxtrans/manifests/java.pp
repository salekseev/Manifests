class jmxtrans::java {

  if ! defined(Package['jdk']) {
    package { 'jdk':
      ensure   => latest,
      provider => 'yum',
      name     =>  'jdk',
    }
  }

  if ! defined(Exec["Install Alternatives java"]) {
    exec {"Install Alternatives java":
      command => "/usr/sbin/alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_51/bin/java 200000",
      require => Package['jdk'],
      logoutput => true,
    }
  }

  if ! defined(Exec["Install Alternatives javaw"]) {
    exec {"Install Alternatives javaw":
      command => "/usr/sbin/alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.7.0_51/jre/bin/javaws 200000",
      require => Package['jdk'],
      logoutput => true,
    }
  }
}
