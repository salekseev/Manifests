# /etc/puppet/postfix/manifests/init.pp

class postfix {

    package { postfix: ensure => latest }
    package { sendmail: ensure => absent }
    package { postfix-perl-scripts: ensure => absent }

    file { "/etc/postfix/main.cf":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/main.cf",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/aliases":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/aliases",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/transport":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/transport",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/aliases.local":
        owner   => root,
        group   => root,
        mode    => 644,
        ensure  => present,
        require => Package["postfix"],
    }

    file { "/etc/postfix/transport.local":
        owner   => root,
        group   => root,
        mode    => 644,
        ensure  => present,
        require => Package["postfix"],
    }

    service { "postfix":
        ensure => running,
        enable => true,
        subscribe => File["/etc/postfix/main.cf"],
    }

    exec { "postalias hash:/etc/postfix/aliases":
        cwd         => "/etc/postfix",
        path        => ["/usr/sbin", "/usr/bin"],
        require     => File["/etc/postfix/aliases"],
        refreshonly  => true,
        subscribe   => File["/etc/postfix/aliases"]
    }

    exec { "postalias hash:/etc/postfix/aliases.local":
        cwd         => "/etc/postfix",
        path        => ["/usr/sbin", "/usr/bin"],
        require     => File["/etc/postfix/aliases.local"],
        refreshonly  => true,
        subscribe   => File["/etc/postfix/aliases.local"]
    }

    exec { "postmap hash:/etc/postfix/transport":
        cwd         => "/etc/postfix",
        path        => ["/usr/sbin", "/usr/bin"],
        require     => File["/etc/postfix/transport"],
        refreshonly  => true,
        subscribe   => File["/etc/postfix/transport"]
    }

    exec { "postmap hash:/etc/postfix/transport.local":
        cwd         => "/etc/postfix",
        path        => ["/usr/sbin", "/usr/bin"],
        require     => File["/etc/postfix/transport.local"],
        refreshonly  => true,
        subscribe   => File["/etc/postfix/transport.local"]
    }
}


class postfix::relay {

    package { postfix:    ensure => '2.10.1-1.el6' }
    package { cyrus-sasl: ensure => latest }
    package { dovecot:    ensure => latest }
    package { sendmail:   ensure => absent }
    package { opendkim:   ensure => '2.8.4-1.el6' }

    file { "/etc/postfix/main.cf":
        owner   => root,
        group   => root,
        mode    => 644,
        content => template( "postfix/main_relay.cf.erb" ),
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/master.cf":
        owner   => root,
        group   => root,
        mode    => 644,
        content => template( "postfix/master.cf.erb" ),
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/aliases":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/aliases_relay",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/transport":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/transport_relay",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/bypass_sender.map":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/bypass_sender.map",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/bypass_recipient.map":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/bypass_recipient.map",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/bypass_recipient.regexp":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/bypass_recipient.regexp",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/client_access.map":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/client_access.map",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/header_checks.pcre":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/header_checks.pcre",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/smtp_header_checks.pcre":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/smtp_header_checks.pcre",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    ### SSL
     file { "/etc/postfix/ssl":
         ensure        => directory,
         owner         => root,
         group         => root,
         mode          => 0755,
         require       => Package["postfix"],
    }

    file { "/etc/postfix/ssl/mail.$datacenter.symnds.com.key":
        owner   => root,
        group   => root,
        mode    => 640,
        source  => "puppet:///modules/postfix/ssl/mail.$datacenter.symnds.com.key",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/ssl/mail.$datacenter.symnds.com.pem":
        owner   => root,
        group   => root,
        mode    => 640,
        source  => "puppet:///modules/postfix/ssl/mail.$datacenter.symnds.com.pem",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/postfix/ssl/verisign-standard-ssl-chain.pem":
        owner   => root,
        group   => root,
        mode    => 640,
        source  => "puppet:///modules/postfix/ssl/verisign-standard-ssl-chain.pem",
        require => Package["postfix"],
        notify  => Service["postfix"],
    }

    file { "/etc/dovecot/dovecot.conf":
        owner   => root,
        group   => root,
        mode    => 640,
        source  => "puppet:///modules/postfix/dovecot/dovecot.conf",
        require => Package["dovecot"],
        notify  => Service["dovecot"],
    }

    file { "/etc/dovecot/conf.d/10-auth.conf":
        owner   => root,
        group   => root,
        mode    => 640,
        source  => "puppet:///modules/postfix/dovecot/10-auth.conf",
        require => Package["dovecot"],
        notify  => Service["dovecot"],
    }

    file { "/etc/dovecot/conf.d/10-master.conf":
        owner   => root,
        group   => root,
        mode    => 640,
        source  => "puppet:///modules/postfix/dovecot/10-master.conf",
        require => Package["dovecot"],
        notify  => Service["dovecot"],
    }

    file { "/etc/opendkim.conf":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///modules/postfix/opendkim.conf",
        require => Package["opendkim"],
        notify  => Service["opendkim"],
    }

    file { "/etc/opendkim":
        ensure  => directory,
        force   => false,
        purge   => false,
        owner   => 'opendkim',
        group   => 'opendkim',
        mode    => 0640,
        source  => "puppet:///modules/postfix/opendkim",
        recurse => true,
        ignore  => '.svn',
        require => Package["opendkim"],
        notify  => Service["opendkim"],
    }

    service { "postfix":
        ensure    => running,
        enable    => true,
        subscribe => File["/etc/postfix/main.cf"],
    }

    service { "opendkim":
        ensure    => running,
        enable    => true,
        subscribe => File["/etc/opendkim.conf"],
        require   => Package["opendkim"],
    }

    service { "dovecot":
        ensure    => running,
        enable    => true,
        subscribe => File["/etc/dovecot/dovecot.conf"],
    }

    ### Create postfix maps
    exec { "postalias hash:/etc/postfix/aliases":
        cwd         => "/etc/postfix",
        path        => ["/usr/sbin", "/usr/bin"],
        require     => File["/etc/postfix/aliases"],
        refreshonly => false,
    }

    exec { "postmap hash:/etc/postfix/transport":
        cwd         => "/etc/postfix",
        path        => ["/usr/sbin", "/usr/bin"],
        require     => File["/etc/postfix/transport"],
        refreshonly => false,
    }

    exec { "postmap hash:/etc/postfix/client_access.map":
        cwd         => "/etc/postfix",
        path        => ["/usr/sbin", "/usr/bin"],
        require     => File["/etc/postfix/client_access.map"],
        refreshonly => false,
    }

    exec { "postmap hash:/etc/postfix/bypass_sender.map":
        cwd         => "/etc/postfix",
        path        => ["/usr/sbin", "/usr/bin"],
	    require     => File["/etc/postfix/bypass_sender.map"],
        refreshonly => false,
    }

    exec { "postmap hash:/etc/postfix/bypass_recipient.map":
        cwd         => "/etc/postfix",
        path        => ["/usr/sbin", "/usr/bin"],
        require     => File["/etc/postfix/bypass_recipient.map"],
        refreshonly => false,
    }
}
