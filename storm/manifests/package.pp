class storm::package inherits storm::params
{

  package { "storm":
    ensure  => $storm_version,
  }

  package { "supervisor":
    ensure => $supervisor_version,
  }

}
