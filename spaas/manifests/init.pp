class spaas (

  $role = $::role
) {

case $role {

  'zookeeper': {
    class { 'zookeeper-hiera': }
  }

  'nimbus': {
    class { 'storm-hiera::nimbus': }
  }

  'supervisor': {
    class { 'storm-hiera::worker': }
  }

  'default': {
    notify { "Invalid Role specified": }
  }

}

}
