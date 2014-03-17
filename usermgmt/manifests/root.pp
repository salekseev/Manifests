class usermgmt::root {

    ### Apply SSD for RHEL variants
    if $operatingsystem =~ /^(CentOS|RedHat|Ubuntu|Ubuninintoo)/ {
        include usermgmt::sssd
    }

    ### Changed for CPE 12/11/2013 - stefan_kolesnikowicz@symantec.com
    user { 'root':
        managehome  => true,
        home        => '/root',
        password    => '$1$RiwiPoge$cj0OhptQi2t.b6in/NDep/',
    }
}
