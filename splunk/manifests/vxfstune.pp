class splunk::vxfstune {
    file { "/etc/vx/tunefstab":
        owner   => 'root',
        group   => 'root',
        mode    => '644',
        source  => 'puppet:///modules/splunk/tunefstab',
    }
}
