class mcollective::client {
    include mcollective::base

      package { mcollective-puppet-agent:  ensure => latest }
      package { mcollective-nettest-agent: ensure => latest }
      package { mcollective-package-agent: ensure => latest }
      package { mcollective-nrpe-agent:    ensure => latest }
      package { mcollective-service-agent: ensure => latest }
      package { mcollective-filemgr-agent: ensure => latest }
}
