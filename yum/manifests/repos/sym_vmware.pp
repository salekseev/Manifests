class yum::repos::sym_vmware {    
    yumrepo { 'sym-vmware':
        descr      => "CentOS-${lsbmajdistrelease} Sym VMWare",
        baseurl    => 'http://yum.symnds.net/mrepo/centos$releasever-$basearch/RPMS.vmware http://mirror.st2.symnds.net/mrepo/centos$releasever-$basearch/RPMS.vmware http://mirror.acc4.symnds.net/mrepo/centos$releasever-$basearch/RPMS.vmware',
        mirrorlist => absent,
        enabled    => '1',
        gpgcheck   => '0',
        priority   => '1'
    }
}
