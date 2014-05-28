class ganglia::config inherits ganglia::params {

  user { 'nobody':
    shell => '/bin/bash',
  }

  $libexecdir = '/usr/libexec/hdp/ganglia'

  exec { 'create-objects-dir':
    path    => "/usr/local/bin/:/usr/bin/:/bin/",
    command => "mkdir -p ${libexecdir}",
    creates => $libexecdir,
  }

  file { 'objects-dir':
    ensure  => directory,
    path    => $libexecdir,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    source  => "puppet:///modules/ganglia/objects",
    require => Exec['create-objects-dir'],
  }

  exec { 'create-exec-config-dir':
    path    => "/usr/local/bin/:/usr/bin/:/bin/",
    command => "mkdir -p /etc/ganglia/hdp",
    creates => '/etc/ganglia/hdp',
  }

  file { 'config-dir-perms':
    ensure  => directory,
    path    => '/etc/ganglia/hdp',
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => Exec['create-exec-config-dir'],
  }


  exec { 'create-run-dir':
    path    => "/usr/local/bin:/usr/bin/:/bin/",
    command => "mkdir -p /var/run/ganglia/hdp",
    creates => "/var/run/ganglia/hdp",
  }

  file { 'manage-run-dir':
    ensure  => directory,
    path    => '/var/run/ganglia/hdp',
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => Exec['create-run-dir'],
  }

  file { 'python-modules-dir':
    ensure  => directory,
    path    => '/usr/lib64/ganglia/python_modules',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { 'modpython.so':
    ensure  => file,
    path    => '/usr/lib64/ganglia/modpython.so',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => "puppet:///modules/ganglia/python_modules/modpython.so",
    require => File['python-modules-dir'],
  }

  file { 'diskstat.py':
    ensure  => file,
    path    => '/usr/lib64/ganglia/python_modules/diskstat.py',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///modules/ganglia/python_modules/diskstat.py",
    require => File['python-modules-dir'],
  }

  file { 'netstats.py':
    ensure  => file,
    path    => '/usr/lib64/ganglia/python_modules/netstats.py',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///modules/ganglia/python_modules/netstats.py",
    require => File['python-modules-dir'],
  }

  if $is_master {

    file { 'gmetad.conf':
      ensure  => file,
      path    => '/etc/ganglia/hdp/gmetad.conf',
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/gmetad.conf.erb'),
      require => File['config-dir-perms'],
    }

    $config_run_dirs = [
      '/etc/ganglia/hdp/HDPZookeeper',
      '/etc/ganglia/hdp/Kafka',
      '/etc/ganglia/hdp/HDPNimbus',
      '/etc/ganglia/hdp/HDPSupervisor',
      '/etc/ganglia/hdp/HDPZookeeper/conf.d',
      '/etc/ganglia/hdp/Kafka/conf.d',
      '/etc/ganglia/hdp/HDPNimbus/conf.d',
      '/etc/ganglia/hdp/HDPSupervisor/conf.d',
      '/var/run/ganglia/hdp/HDPZookeeper',
      '/var/run/ganglia/hdp/Kafka',
      '/var/run/ganglia/hdp/HDPNimbus',
      '/var/run/ganglia/hdp/HDPSupervisor']

    file { $config_run_dirs:
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0755',
      require => [File['config-dir-perms'],File['manage-run-dir']],
    }

    file { 'zookeeper-core-config':
      path    => '/etc/ganglia/hdp/HDPZookeeper/gmond.core.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/ZooKeeper/gmond.core.conf.erb'),
      require => File[$config_run_dirs], 
    }

    file { 'zookeeper-master-config':
      path    => '/etc/ganglia/hdp/HDPZookeeper/conf.d/gmond.master.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/ZooKeeper/conf.d/gmond.master.conf.erb'),
      require => File[$config_run_dirs],
    }

    file { 'kafka-core-config':
      path    => '/etc/ganglia/hdp/Kafka/gmond.core.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/Kafka/gmond.core.conf.erb'),
      require => File[$config_run_dirs], 
    }

    file { 'kafka-master-config':
      path    => '/etc/ganglia/hdp/Kafka/conf.d/gmond.master.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/Kafka/conf.d/gmond.master.conf.erb'),
      require => File[$config_run_dirs],
    }

    file { 'nimbus-core-config':
      path    => '/etc/ganglia/hdp/HDPNimbus/gmond.core.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/Nimbus/gmond.core.conf.erb'),
      require => File[$config_run_dirs], 
    }

    file { 'nimbus-master-config':
      path    => '/etc/ganglia/hdp/HDPNimbus/conf.d/gmond.master.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/Nimbus/conf.d/gmond.master.conf.erb'),
      require => File[$config_run_dirs],
    }

    file { 'storm-core-config':
      path    => '/etc/ganglia/hdp/HDPSupervisor/gmond.core.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/Storm/gmond.core.conf.erb'),
      require => File[$config_run_dirs], 
    }

    file { 'storm-master-config':
      path    => '/etc/ganglia/hdp/HDPSupervisor/conf.d/gmond.master.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/Storm/conf.d/gmond.master.conf.erb'),
      require => File[$config_run_dirs],
    }

  }

  if $zoo_client {

    if ! defined(File['/etc/ganglia/hdp/HDPZookeeper']) {
      file { '/etc/ganglia/hdp/HDPZookeeper':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => File['config-dir-perms'],
      }
    }

    if ! defined(File['/var/run/ganglia/hdp/HDPZookeeper']) {
      file { '/var/run/ganglia/hdp/HDPZookeeper':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
      }
    }

    if ! defined(File['/etc/ganglia/hdp/HDPZookeeper/conf.d']) {
      file { '/etc/ganglia/hdp/HDPZookeeper/conf.d':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => File['config-dir-perms'],
      }
    }

    if ! defined(File['zookeeper-core-config']) {
      file { 'zookeeper-core-config':
        path    => '/etc/ganglia/hdp/HDPZookeeper/gmond.core.conf',
        ensure  => file,
        owner   => $user,
        group   => $group,
        mode    => '0644',
        content => template('ganglia/ZooKeeper/gmond.core.conf.erb'),
        require => File['config-dir-perms'], 
      }
    }

    file { 'zoo-client-config':
      path    => '/etc/ganglia/hdp/HDPZookeeper/conf.d/gmond.slave.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/ZooKeeper/conf.d/gmond.slave.conf.erb'),
      require => File['config-dir-perms'],
    }

    file { 'zoo-diskstat-config':
      path    => '/etc/ganglia/hdp/HDPZookeeper/conf.d/diskstat.pyconf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      source  => "puppet:///modules/ganglia/python_modules/diskstat.pyconf",
      require => File['config-dir-perms'],
    }

    file { 'zoo-netstats-config':
      path    => '/etc/ganglia/hdp/HDPZookeeper/conf.d/netstats.pyconf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      source  => "puppet:///modules/ganglia/python_modules/netstats.pyconf",
      require => File['config-dir-perms'],
    }
  }

  if $kafka_client {

    if ! defined(File['/etc/ganglia/hdp/Kafka']) {
      file { '/etc/ganglia/hdp/Kafka':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => File['config-dir-perms'],
      }
    }

    if ! defined(File['/var/run/ganglia/hdp/Kafka']) {
      file { '/var/run/ganglia/hdp/Kafka':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
      }
    }

    if ! defined(File['/etc/ganglia/hdp/Kafka/conf.d']) {
      file { '/etc/ganglia/hdp/Kafka/conf.d':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => File['config-dir-perms'],
      }
    }

    if ! defined(File['kafka-core-config']) {
      file { 'kafka-core-config':
        path    => '/etc/ganglia/hdp/Kafka/gmond.core.conf',
        ensure  => file,
        owner   => $user,
        group   => $group,
        mode    => '0644',
        content => template('ganglia/Kafka/gmond.core.conf.erb'),
        require => File['config-dir-perms'], 
      }
    }

    file { 'kafka-client-config':
      path    => '/etc/ganglia/hdp/Kafka/conf.d/gmond.slave.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/Kafka/conf.d/gmond.slave.conf.erb'),
      require => File['config-dir-perms'],
    }

    file { 'kafka-diskstat-config':
      path    => '/etc/ganglia/hdp/Kafka/conf.d/diskstat.pyconf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      source  => "puppet:///modules/ganglia/python_modules/diskstat.pyconf",
      require => File['config-dir-perms'],
    }

    file { 'kafka-netstats-config':
      path    => '/etc/ganglia/hdp/Kafka/conf.d/netstats.pyconf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      source  => "puppet:///modules/ganglia/python_modules/netstats.pyconf",
      require => File['config-dir-perms'],
    }
  }


  if $nimbus_client {

    if ! defined(File['/etc/ganglia/hdp/HDPNimbus']) {
      file { '/etc/ganglia/hdp/HDPNimbus':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => File['config-dir-perms'],
      }
    }

    if ! defined(File['/var/run/ganglia/hdp/HDPNimbus']) {
      file { '/var/run/ganglia/hdp/HDPNimbus':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
      }
    }

    if ! defined(File['/etc/ganglia/hdp/HDPNimbus/conf.d']) {
      file { '/etc/ganglia/hdp/HDPNimbus/conf.d':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => File['config-dir-perms'],
      }
    }

    if ! defined(File['nimbus-core-config']) {
      file { 'nimbus-core-config':
        path    => '/etc/ganglia/hdp/HDPNimbus/gmond.core.conf',
        ensure  => file,
        owner   => $user,
        group   => $group,
        mode    => '0644',
        content => template('ganglia/Nimbus/gmond.core.conf.erb'),
        require => File['config-dir-perms'], 
      }
    }

    file { 'nimbus-client-config':
      path    => '/etc/ganglia/hdp/HDPNimbus/conf.d/gmond.slave.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/Nimbus/conf.d/gmond.slave.conf.erb'),
      require => File['config-dir-perms'],
    }

    file { 'nimbus-diskstat-config':
      path    => '/etc/ganglia/hdp/HDPNimbus/conf.d/diskstat.pyconf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      source  => "puppet:///modules/ganglia/python_modules/diskstat.pyconf",
      require => File['config-dir-perms'],
    }

    file { 'nimbus-netstats-config':
      path    => '/etc/ganglia/hdp/HDPNimbus/conf.d/netstats.pyconf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      source  => "puppet:///modules/ganglia/python_modules/netstats.pyconf",
      require => File['config-dir-perms'],
    }
  }

  if $storm_client {

    if ! defined(File['/etc/ganglia/hdp/HDPSupervisor']) {
      file { '/etc/ganglia/hdp/HDPSupervisor':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => File['config-dir-perms'],
      }
    }

    if ! defined(File['/var/run/ganglia/hdp/HDPSupervisor']) {
      file { '/var/run/ganglia/hdp/HDPSupervisor':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
      }
    }

    if ! defined(File['/etc/ganglia/hdp/HDPSupervisor/conf.d']) {
      file { '/etc/ganglia/hdp/HDPSupervisor/conf.d':
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => File['config-dir-perms'],
      }
    }

    if ! defined(File['storm-core-config']) {
      file { 'storm-core-config':
        path    => '/etc/ganglia/hdp/HDPSupervisor/gmond.core.conf',
        ensure  => file,
        owner   => $user,
        group   => $group,
        mode    => '0644',
        content => template('ganglia/Storm/gmond.core.conf.erb'),
        require => File['config-dir-perms'], 
      }
    }

    file { 'storm-client-config':
      path    => '/etc/ganglia/hdp/HDPSupervisor/conf.d/gmond.slave.conf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      content => template('ganglia/Storm/conf.d/gmond.slave.conf.erb'),
      require => File['config-dir-perms'],
    }

    file { 'storm-diskstat-config':
      path    => '/etc/ganglia/hdp/HDPSupervisor/conf.d/diskstat.pyconf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      source  => "puppet:///modules/ganglia/python_modules/diskstat.pyconf",
      require => File['config-dir-perms'],
    }

    file { 'storm-netstats-config':
      path    => '/etc/ganglia/hdp/HDPSupervisor/conf.d/netstats.pyconf',
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      source  => "puppet:///modules/ganglia/python_modules/netstats.pyconf",
      require => File['config-dir-perms'],
    }

  }

}
