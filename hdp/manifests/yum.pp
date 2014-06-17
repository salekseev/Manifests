class hdp::yum {
yumrepo { 'hdp':
        descr      => "HDPrepo",
        baseurl    => 'http://10.119.134.28/mrepo/horton/HDP-2.1.2.1',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
yumrepo { 'hdp-util':
        descr      => "HDPutilrepo",
        baseurl    => 'http://10.119.134.28/mrepo/horton/HDP-UTILS-1.1.0.17',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
yumrepo { 'ambari':
        descr      => "HDPambarirepo",
        baseurl    => 'http://10.119.134.28/mrepo/horton/Updates-ambari-1.6',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
        notify     => Exec[ "yum_makecache" ]
    }
}
