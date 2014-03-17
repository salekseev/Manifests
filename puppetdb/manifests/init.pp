### PuppetDB class
class puppetdb {
    package { 'puppetdb': ensure => latest }
    package { 'jdk'     : ensure => latest }

    service { 'puppetdb':
        ensure  => 'running',
        enable  => true,
        require => Package[ 'puppetdb' ],
    }

    file { '/etc/sysconfig/puppetdb':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => 'puppet:///modules/puppetdb/puppetdb.sysconfig',
        require => Package[ 'puppetdb' ],
        notify  => Service[ 'puppetdb' ],
    }

    file { '/etc/puppetdb/log4j.properties':
        owner   => 'puppetdb',
        group   => 'puppetdb',
        mode    => '0640',
        source  => 'puppet:///modules/puppetdb/log4j.properties',
        require => Package[ 'puppetdb' ],
        notify  => Service[ 'puppetdb' ],
    }

    file { '/etc/puppetdb/conf.d/config.ini':
        owner   => 'puppetdb',
        group   => 'puppetdb',
        mode    => '0640',
        source  => 'puppet:///modules/puppetdb/config.ini',
        require => Package[ 'puppetdb' ],
        notify  => Service[ 'puppetdb' ],
    }

    file { '/etc/puppetdb/conf.d/jetty.ini':
        owner   => 'puppetdb',
        group   => 'puppetdb',
        mode    => '0640',
        source  => 'puppet:///modules/puppetdb/jetty.ini',
        require => Package[ 'puppetdb' ],
        notify  => Service[ 'puppetdb' ],
    }

    file { '/etc/puppetdb/conf.d/database.ini':
        owner   => 'puppetdb',
        group   => 'puppetdb',
        mode    => '0640',
        source  => 'puppet:///modules/puppetdb/database.ini',
        require => Package[ 'puppetdb' ],
        notify  => Service[ 'puppetdb' ],
    }

    class { 'nginx':
        nginx_conf_path => 'puppetdb/nginx.conf.puppetdb.erb',
    }

    file { '/etc/nginx/ssl':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0750',
        require => Package[ 'nginx' ],
    }

    file { '/etc/nginx/ssl/certs':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0750',
        require => [ Package[ 'nginx' ], File[ '/etc/nginx/ssl' ] ],
    }

    file { '/etc/nginx/ssl/keys':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0750',
        require => [ Package[ 'nginx' ], File[ '/etc/nginx/ssl' ] ],
    }

    file { '/etc/nginx/ssl/keys/puppetdb.acc4.symnds.net.key':
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        source  => 'puppet:///puppetdb/puppetdb.acc4.symnds.net.key',
        require => [ Package[ 'nginx' ], File[ '/etc/nginx/ssl/keys' ] ],
    }
    file { '/etc/nginx/ssl/certs/puppetdb.acc4.symnds.net.cert':
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        source  => 'puppet:///puppetdb/puppetdb.acc4.symnds.net.cert',
        require => [ Package[ 'nginx' ], File[ '/etc/nginx/ssl/certs' ] ],
    }

    file { '/etc/nginx/ssl/keys/puppetdb.acc5.symnds.net.key':
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        source  => 'puppet:///puppetdb/puppetdb.acc5.symnds.net.key',
        require => [ Package[ 'nginx' ], File[ '/etc/nginx/ssl/keys' ] ],
    }
    file { '/etc/nginx/ssl/certs/puppetdb.acc5.symnds.net.cert':
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        source  => 'puppet:///puppetdb/puppetdb.acc5.symnds.net.cert',
        require => [ Package[ 'nginx' ], File[ '/etc/nginx/ssl/certs' ] ],
    }

    file { '/etc/nginx/ssl/keys/puppetdb.st2.symnds.net.key':
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        source  => 'puppet:///puppetdb/puppetdb.st2.symnds.net.key',
        require => [ Package[ 'nginx' ], File[ '/etc/nginx/ssl/keys' ] ],
    }
    file { '/etc/nginx/ssl/certs/puppetdb.st2.symnds.net.cert':
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        source  => 'puppet:///puppetdb/puppetdb.st2.symnds.net.cert',
        require => [ Package[ 'nginx' ], File[ '/etc/nginx/ssl/certs' ] ],
    }

}
