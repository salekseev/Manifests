class hdp-util {

  class { 'hdp-util::repo': } ->
  class { 'hdp-util::java': }

}
