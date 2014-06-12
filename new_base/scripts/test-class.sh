#!/bin/bash
CLASS=$1
if [ -z $CLASS ]; then
  echo "Usage: $0 classname"
  exit 1
fi
# --execute "include $1" \
sudo puppet apply -v \
 --modulepath=./modules \
 --factpath=./modules/base/lib/facter \
 --fileserverconfig=./scripts/fileserver.conf \
<<EOF
Exec {
  path => [
    "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/",
    "/usr/local/bin/", "/usr/local/sbin/",
  ]
}
notice(">>> datacenter is $::datacenter <<<")
notice(">>> host_environment is $::host_environment <<<")
notice(">>> fqdn is $::fqdn <<<")
notice(">>> hostgroup is $::hostgroup <<<")
notice(">>> is_virtual is $::is_virtual <<<")
notice(">>> osfamily is $::osfamily <<<")
notice(">>> operatingsystem is $::operatingsystem <<<")
notice(">>> operatingsystemrelease is $::operatingsystemrelease <<<")
include ${CLASS}
EOF
