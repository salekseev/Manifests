# /etc/puppet/modules/sudoers/manifests/init.pp

### CPE JUMPBOXES

class sudoers::base {
    package { 'sudo': ensure => latest }
}

class sudoers::infrastructure {
    include sudoers::base
    file { '/etc/sudoers':
        owner   => root,
        group   => root,
        mode    => '0440',
        source  => "puppet:///modules/sudoers/sudoers",
    }
}


class sudoers::bigdata {
    include sudoers::base
    file { '/etc/sudoers':
        owner   => root,
        group   => root,
        mode    => '0440',
        source  => "puppet:///modules/sudoers/sudoers-bigdata",
    }
}

class sudoers::jumpbox {
    include sudoers::base
    file { '/etc/sudoers':
        owner   => root,
        group   => root,
        mode    => '0440',
        source  => "puppet:///modules/sudoers/sudoers-jump",
    }
}

class sudoers::infservices {
    include sudoers::base
    file { '/etc/sudoers':
        owner   => root,
        group   => root,
        mode    => '0440',
        source  => "puppet:///modules/sudoers/sudoers-infservices",
    }
}

class sudoers::logmon {
	include sudoers::base    
	file { '/etc/sudoers':
        owner   => root,
        group   => root,
        mode    => '0440',
        source  => "puppet:///modules/sudoers/sudoers-logmon",
    }
}

### EOF
