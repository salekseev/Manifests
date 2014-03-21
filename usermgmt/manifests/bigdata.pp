class usermgmt::bigdata {
#adduser for zaloni
    user { 'zaloni':
                ensure          => present,
                home            => '/home/zaloni',
                shell           => '/bin/bash',
                comment         => 'zaloni',
                managehome      => true,
                password        => '$1$gCSzFaCJ$XbEis37L6w9OCv98M.wwZ.',
                uid             => 1000,
                gid             => 1000,
                require         => Group['zaloni','wheel'],
                groups          => 'wheel',
    }
    group { 'zaloni':
                ensure          => present,
                gid             => 1000,
    }

}
