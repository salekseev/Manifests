class jmxtrans {

  class { jmxtrans::repo: } ->
  class { jmxtrans::java: } ->
  class { jmxtrans::install: } ->
  class { jmxtrans::config: } ->
  class { jmxtrans::service: }

}
