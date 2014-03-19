class hadoop::oozie (
){

    package { oozie:
        ensure => latest,
        provider => 'yum',
        name    =>  'oozie',
        require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
   }

    package { oozie-client:
        ensure => latest,
        provider => 'yum',
        name    =>  'oozie-client',
        require => Yumrepo[ "HDP-1.2.0-1-1.x" , "HDP-UTILS-1.1.0.15" ,  "Updates-HDP-1.2.0-1-1.2.1" , "ambari-1.x" , "HDP-UTILS-1.1.0.16" , "Updates-ambari-1.x" ],
   }



}
