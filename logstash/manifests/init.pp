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
# Michael Brush <michael_brush@symantec.com>
#
# === Copyright
#
# Copyright 2014 Symantec, unless otherwise noted.
#
class logstash inherits logstash::params {

  if ! defined(Class["hdp-util"]) {
    class { "hdp-util": }
  }
  class { "logstash::package":
    require => Class["hdp-util"]
  } ->
  class { "logstash::directories": }

  if ($logstash_storm_nimbus) {
    class { "logstash::storm_nimbus":
      require => Class["logstash::directories"],
    }
  }

  if ($logstash_storm_ui) {
    class { "logstash::storm_ui":
      require => Class["logstash::directories"],
    }
  }

  if ($logstash_storm_supervisor) {
    class { "logstash::storm_supervisor":
      require => Class["logstash::directories"],
    }
  }

  if ($logstash_storm_worker) {
    class { "logstash::storm_worker":
      require => Class["logstash::directories"],
    }
  }


}
