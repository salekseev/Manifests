class hadoop::users {
    user { 'hdfs':
                ensure          => present,
                home            => '/home/hdfs/',
                shell           => '/bin/bash',
                comment         => 'hdfs service',
                managehome      => true,
                password        => '$1$Q47mRmeW$8QSWCjyTVGvazcamP.HA60',
                uid             => 1100,
                gid             => 1100,
                require         => Group['hadoop'],
                groups          => 'hadoop',
    }
    group { 'hadoop':
                ensure          => present,
                gid             => 1100,
    }

    user { 'mapred':
                ensure          => present,
                home            => '/home/mapred/',
                shell           => '/bin/bash',
                comment         => 'mapred service',
                managehome      => true,
                password        => '$1$Q47mRmeW$8QSWCjyTVGvazcamP.HA60',
                uid             => 1101,
                gid             => 1100,
                require         => Group['hadoop'],
                groups          => 'hadoop',
    }

    user { 'hive':
                ensure          => present,
                home            => '/home/',
                shell           => '/bin/bash',
                comment         => 'hive service',
                managehome      => true,
                password        => '$1$Q47mRmeW$8QSWCjyTVGvazcamP.HA60',
                uid             => 1102,
                gid             => 1100,
                require         => Group['hadoop'],
                groups          => 'hadoop',
    }


    user { 'pig':
                ensure          => present,
                home            => '/home/',
                shell           => '/bin/bash',
                comment         => 'pig service',
                managehome      => true,
                password        => '$1$Q47mRmeW$8QSWCjyTVGvazcamP.HA60',
                uid             => 1103,
                gid             => 1100,
                require         => Group['hadoop'],
                groups          => 'hadoop',
    }


}

