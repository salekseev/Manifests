class jmxtrans {

  if ! defined(Class["hdp-util"]) {
    class { "hdp-util": }
  }

  class { jmxtrans::install:
    require => Class["hdp-util"],
  } ->

  class { jmxtrans::config: } ->
  class { jmxtrans::service: }

}
