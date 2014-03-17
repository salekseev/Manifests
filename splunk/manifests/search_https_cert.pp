class splunk::search_https_cert {
	file { '/opt/splunk/etc/system/local/web.conf':
        owner   => 'root',
        group   => 'root',
        mode    => '600',
        source  => 'puppet:///modules/splunk/splunk-web.conf',
	}

	file { '/opt/splunk/etc/auth/splunkweb/symnds.net.key':
        owner   => 'root',
        group   => 'root',
        mode    => '600',
        source  => 'puppet:///modules/splunk/symnds.net.key',
	}

	file { '/opt/splunk/etc/auth/splunkweb/symnds.net.pem':
        owner   => 'root',
        group   => 'root',
        mode    => '600',
        source  => 'puppet:///modules/splunk/symnds.net.pem',
	}

	exec { 'splunk restart splunkweb':
		path		=> ['/opt/splunk/bin'],
		refreshonly => true,
		subscribe	=> File['/opt/splunk/etc/system/local/web.conf', '/opt/splunk/etc/auth/splunkweb/symnds.net.key', '/opt/splunk/etc/auth/splunkweb/symnds.net.pem' ],
	}
}

