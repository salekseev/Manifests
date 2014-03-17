class splunk::search_head_motd {
	file { '/etc/motd':
        owner   => 'root',
        group   => 'root',
        mode    => '644',
        source  => 'puppet:///modules/splunk/splunk-search-head-motd',
	}
}

