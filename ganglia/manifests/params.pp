class ganglia::params (

  $is_master     = hiera('is_master', false),
  $user          = hiera('user', 'nobody'),
  $group         = hiera('group', 'nobody'),
  $master_node   = hiera('master_node'),
  $cluster       = hiera('cluster', 'HDP'),
  $grid          = hiera('grid', 'HDP'),
  $interval      = hiera('interval', '30'),
  $zoo_client    = hiera('zoo_client', false),
  $kafka_client  = hiera('kafka_client', false),
  $nimbus_client = hiera('nimbus_client', false),
  $storm_client  = hiera('storm_client', false),

) { }

