class jmxtrans::repo {

  if ! defined(Yumrepo['hdp']) {

    yumrepo { 'hdp':
      descr      => "HDPrepo",
      baseurl    => 'http://10.119.134.28/mrepo/horton/HDP-2.1.1.0',
      enabled    => '1',
      gpgcheck   => '0',
      priority   => '1',
    }
  }

  if ! defined(Yumrepo['hdp-util']) {
    yumrepo { 'hdp-util':
      descr      => "HDPutilrepo",
      baseurl    => 'http://10.119.134.28/mrepo/horton/HDP-UTILS-1.1.0.17',
      enabled    => '1',
      gpgcheck   => '0',
      priority   => '1',
    }
  }

  if ! defined(Yumrepo['ambari']) {
    yumrepo { 'ambari':
      descr      => "HDPambarirepo",
      baseurl    => 'http://10.119.134.28/mrepo/horton/Updates-ambari-1.5.1',
      enabled    => '1',
      gpgcheck   => '0',
      priority   => '1',
    }
  }
}
