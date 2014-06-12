# == Class: logstash
#
# Full description of class logstash here.
#
# === Parameters
#
# Document parameters here.
#
#
# === Variables
#
#
# === Examples
#
#
# === Authors
#
# Mahesh Nagaraj <mahesh_nagaraj@symantec.com>
#
# === Copyright
#
# Copyright 2014 Symantec, unless otherwise noted.
#
class logstash {

  file { "/opt/logstash":
        ensure => "directory",
  }

  include logstash::directories
  include logstash::params
  include logstash::package
  class {"logstash::bdse":
    require  => Class["logstash::directories"],
  }
  class {"logstash::hadoop":
    require  => Class["logstash::directories"],
  }
}
