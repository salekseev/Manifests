### Manage the /etc/yum.repos.d entries
class yum {
    case $::lsbmajdistrelease {
        '5': {
             package { 'yum-priorities': ensure => latest }
             package { 'yum-security':   ensure => latest }
         }
        '6': {
             package { 'yum-plugin-priorities': ensure => latest }
             package { 'yum-plugin-security':   ensure => latest }
         }
    default: {}
    }

    file { '/etc/yum.conf':
        owner          => root,
        group          => root,
        mode           => '0444',
        source         => 'puppet:///modules/yum/yum.conf',
    }

    ### Remove old entries or leftovers from the install
    file { [ '/etc/yum.repos.d/CentOS-Base.repo',
             '/etc/yum.repos.d/CentOS-Media.repo',
             '/etc/yum.repos.d/CentOS-Testing.repo',
             '/etc/yum.repos.d/epel.repo',
             '/etc/yum.repos.d/epel-testing.repo',
             '/etc/yum.repos.d/CentOS-Debuginfo.repo',
             '/etc/yum.repos.d/CentOS-Vault.repo',
             '/etc/yum.repos.d/vmware.repo',
             '/etc/yum.repos.d/cobbler-config.repo' ]: ensure => absent }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-5':
        owner          => root,
        group          => root,
        mode           => '0444',
        source         => 'puppet:///modules/yum/RPM-GPG-KEY-EPEL-5',
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6':
        owner          => root,
        group          => root,
        mode           => '0444',
        source         => 'puppet:///modules/yum/RPM-GPG-KEY-EPEL-6',
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5':
        owner          => root,
        group          => root,
        mode           => '0444',
        source         => 'puppet:///modules/yum/RPM-GPG-KEY-CentOS-5',
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6':
        owner          => root,
        group          => root,
        mode           => '0444',
        source         => 'puppet:///modules/yum/RPM-GPG-KEY-CentOS-6',
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Testing-5':
        owner          => root,
        group          => root,
        mode           => '0444',
        source         => 'puppet:///modules/yum/RPM-GPG-KEY-CentOS-Testing-5',
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Testing-6':
        owner          => root,
        group          => root,
        mode           => '0444',
        source         => 'puppet:///modules/yum/RPM-GPG-KEY-CentOS-Testing-6',
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Security-6':
        owner          => root,
        group          => root,
        mode           => '0444',
        source         => 'puppet:///modules/yum/RPM-GPG-KEY-CentOS-Security-6',
    }

    file { '/etc/pki/rpm-gpg/VMWARE-PACKAGING-GPG-KEY':
        owner          => root,
        group          => root,
        mode           => '0444',
        source         => 'puppet:///modules/yum/VMWARE-PACKAGING-GPG-KEY.pub',
    }

    file { '/etc/pki/rpm-gpg/VMWARE-PACKAGING-GPG-DSA-KEY':
        owner          => root,
        group          => root,
        mode           => '0444',
        source         => 'puppet:///modules/yum/VMWARE-PACKAGING-GPG-DSA-KEY.pub',
    }

    file { '/etc/yum/pluginconf.d/fastestmirror.conf':
        owner          => root,
        group          => root,
        mode           => '0644',
        source         => 'puppet:///modules/yum/fastestmirror.conf',
    }

    $enable_testing_repo = $enable_testing_repo ? { undef => 'disabled', default => $enable_testing_repo }

    ### Populate yum based on RHEL vs CentOS/Other
    case $::lsbdistid {
         ### RHEL Only
        'RedHatEnterpriseServer': {
            include yum::repos::rhel_base
         }
         default:{
            include yum::repos::sym_base
            include yum::repos::sym_updates

            if ( $enable_testing_repo =~ /^enabled/ ) {
                include yum::repos::sym_testing
            }

            include yum::repos::sym_extras
         }
    }

    ### Common between RHEL/CentOS
    include yum::repos::sym_epel
    #include yum::repos::sym_epel_testing
    #include yum::repos::sym_vmware
    include yum::repos::sym_psql
    include yum::repos::cpe_custom
    include yum::repos::sym_cdh4
    include yum::repos::sym_puppet

    if $::manufacturer =~ /Dell Inc./ {
        include yum::repos::sym_dell
    }

    if (($::host_environment =~ /^(dev|all)/) or ($::fqdn =~ /^dev/)) {
        include yum::repos::sym_dev
    }

    if (($::host_environment =~ /^(qa|all)/) or ($::fqdn =~ /^qa1|qa2|qa3/)) {
        include yum::repos::sym_qa
    }

    if $::host_role =~ /^mysql/ {
        include yum::repos::sym_percona
    }

    if $::host_role =~ /^syslog/ {
        include yum::repos::sym_rsyslog
    }

    if $::host_role =~ /^postgresql/ {
        include yum::repos::sym_psql
    }

    exec { 'yum_makecache':
        path        => '/usr/bin:/usr/sbin:/sbin:/bin',
        command     => '/usr/bin/yum makecache',
        refreshonly => true,
    }
    Exec['yum_makecache'] -> Package<||>

    file { '/etc/facter/packages.d':
        ensure => 'directory',
        owner  => 'puppet',
        group  => 'puppet',
        mode   => '0755'
    }

    file { '/etc/cron.d/facter_yum_facts':
        owner   => root,
        group   => root,
        mode    => '0644',
        source  => 'puppet:///modules/yum/facter_yum_facts_cron',

    }

    file { '/usr/local/sbin/facter_yum_facts.pl':
        owner   => root,
        group   => root,
        mode    => '0755',
        source  => 'puppet:///modules/yum/facter_yum_facts.pl',
    }

    file { '/usr/local/sbin/facter_package_facts.pl':
        owner   => root,
        group   => root,
        mode    => '0755',
        source  => 'puppet:///modules/yum/facter_package_facts.pl',
    }

    file { '/etc/cron.d/facter_package_facts':
        owner   => root,
        group   => root,
        mode    => '0644',
        source  => 'puppet:///modules/yum/facter_package_facts_cron',
    }
}
### EOF
