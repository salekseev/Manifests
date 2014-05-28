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
class logstash {

  if ! defined(Class['hdp-util']) {
    class { 'hdp-util': }
  }
  class { 'logstash::package':
    require => Class['hdp-util']
  }

}
