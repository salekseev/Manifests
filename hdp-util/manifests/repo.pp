class hdp-util::repo {

  if ! defined(Yumrepo['sym-epel']) {
    yumrepo { 'sym-epel':
        gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6",
        descr          => "CentOS-6 - Extra Packages",
        baseurl        => 'http://10.119.134.28/mrepo/centos6-x86_64/RPMS.epel',
        enabled        => '1',
        failovermethod => 'priority',
        gpgcheck       => '0',
        priority       => '1',
        exclude        => 'rabbit*,puppet*,dkms*',
    }
  }

  if ! defined(Yumrepo['cpe-custom']) {
    yumrepo { 'cpe-custom':
        descr      => "CentOS-${lsbmajdistrelease} CPE Custom",
        baseurl    => 'http://10.119.134.28/mrepo/sym-cpe/6/x86_64',
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1',
    }
  }
  
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
