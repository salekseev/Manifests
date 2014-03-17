class splunk::search_distsearch {
	file { '/opt/splunk/etc/system/local/distsearch.conf':
        owner   => 'root',
        group   => 'root',
        mode    => '600',
        source  => 'puppet:///modules/splunk/splunk-search-head-distsearch.conf',
	}

	exec { 'splunk restart':
		path		=> ['/opt/splunk/bin'],
		refreshonly => true,
		subscribe	=> File['/opt/splunk/etc/system/local/distsearch.conf'],
	}
}

