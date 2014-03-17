class splunk::search_indexer_motd {
	file { '/etc/motd':
        owner   => 'root',
        group   => 'root',
        mode    => '644',
        source  => 'puppet:///modules/splunk/splunk-indexer-motd',
	}
}

