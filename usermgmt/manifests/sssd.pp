
# User Management Puppet module
# $Id: init.pp 891 2012-07-23 19:16:25Z bseitz $
#

class usermgmt::sssd {

    package { 'sssd':        ensure => latest }
    package { 'sssd-tools':  ensure => latest }

    $datacenter = $datacenter ? { undef => 'ash1', default => $datacenter }

    case $operatingsystem {
        /^CentOS|RedHat$/: {

            package { 'sssd-client': ensure => latest }
            package { 'oddjob':      ensure => latest }

            case $lsbmajdistrelease {
                /^6/: { package { 'oddjob-mkhomedir': ensure => latest } }
                /^5/: { package { 'oddjob-libs':      ensure => latest } }
            }

            file { '/etc/login.defs':
                    ensure          => present,
                    owner           => 'root',
                    group           => 'root',
                    mode            => '0644',
                    source          => "puppet:///modules/usermgmt/sssd/login.defs.${lsbmajdistrelease}",
            }

            file { '/etc/nsswitch.conf':
                    ensure          => present,
                    owner           => 'root',
                    group           => 'root',
                    mode            => '0644',
                    source          => "puppet:///modules/usermgmt/sssd/nsswitch.conf.${lsbmajdistrelease}",
                    require         => Package['sssd'],
            }

            file { '/etc/pam.d/system-auth-ac':
                    ensure          => present,
                    owner           => 'root',
                    group           => 'root',
                    mode            => '0644',
                    source          => "puppet:///modules/usermgmt/sssd/system-auth-ac.${lsbmajdistrelease}",
                    require         => Package['sssd'],
            }

            file { '/etc/pam.d/password-auth-ac':
                    ensure          => present,
                    owner           => 'root',
                    group           => 'root',
                    mode            => '0644',
                    source          => 'puppet:///modules/usermgmt/sssd/password-auth',
                    require         => Package['sssd'],
            }

            service { 'messagebus': ensure => running, enable => true }
            service { 'oddjobd': ensure => running, enable => true, require => Service['messagebus']  }
        }
        /[Uu]buntu/: {
            file { '/etc/pam.d/common-session':
                    ensure          => present,
                    owner           => 'root',
                    group           => 'root',
                    mode            => '0644',
                    source          => 'puppet:///modules/usermgmt/sssd/common-session',
                    require         => Package['sssd'],
            }
        }
        default: {}
    }

    ### Common
    file { '/etc/sssd/sssd.conf':
        ensure          => present,
        owner           => 'root',
        group           => 'root',
        mode            => '0600',
        source          => "puppet:///modules/usermgmt/sssd/sssd.conf",
        require         => Package['sssd'],
        notify          => Service['sssd'],
    }

    service { 'sssd':    ensure => running, enable => true }
}
