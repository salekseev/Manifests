class hadoop::yum {
    yumrepo { 'HDP-1.2.0-1-1.x':
        gpgkey     => "http://public-repo-1.hortonworks.com/HDP-1.2.0-1/centos6/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins",
        descr      => "Hortonworks Data Platform Version - HDP-1.2.0-1-1.x",
        mirrorlist => absent,
        baseurl    => 'http://public-repo-1.hortonworks.com/HDP-1.2.0-1/centos6/1.x/GA',
        gpgcheck   => '0',
        enabled    => '1',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }

    yumrepo { 'HDP-UTILS-1.1.0.15':
        gpgkey     => "http://public-repo-1.hortonworks.com/HDP-1.2.0-1/centos6/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins",
        descr      => "Hortonworks Data Platform Utils Version - HDP-UTILS-1.1.0.15",
        mirrorlist => absent,
        baseurl    => 'http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.15/repos/centos6',
        gpgcheck   => '0',
        enabled    => '1',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }

    yumrepo { 'Updates-HDP-1.2.0-1-1.2.1':
        gpgkey     => "http://public-repo-1.hortonworks.com/HDP-1.2.0-1/centos6/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins",
        descr      => "HDP-1.2.1 - Updates",
        mirrorlist => absent,
        baseurl    => 'http://public-repo-1.hortonworks.com/HDP-1.2.0-1/centos6/1.x/updates/1.2.1',
        gpgcheck   => '0',
        enabled    => '1',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }

    yumrepo { 'ambari-1.x':
        gpgkey     => "http://public-repo-1.hortonworks.com/ambari/centos6/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins",
        descr      => "Ambari 1.x",
        mirrorlist => absent,
        baseurl    => 'http://public-repo-1.hortonworks.com/ambari/centos6/1.x/GA',
        gpgcheck   => '1',
        enabled    => '1',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }

    yumrepo { 'HDP-UTILS-1.1.0.16':
        gpgkey     => "http://public-repo-1.hortonworks.com/ambari/centos6/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins",
        descr      => "Hortonworks Data Platform Utils Version - HDP-UTILS-1.1.0.16",
        mirrorlist => absent,
        baseurl    => 'http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.16/repos/centos6',
        gpgcheck   => '0',
        enabled    => '1',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }

    yumrepo { 'Updates-ambari-1.x':
        gpgkey     => "http://public-repo-1.hortonworks.com/ambari/centos6/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins",
        descr      => "ambari-1.x - Updates",
        mirrorlist => absent,
        baseurl    => 'http://public-repo-1.hortonworks.com/ambari/centos6/1.x/updates',
        gpgcheck   => '1',
        enabled    => '1',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }


}

