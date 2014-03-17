class splunk::search_head_configs {
	file { '/opt/splunk/etc/system/local/alert_actions.conf':
        owner   => 'root',
        group   => 'root',
        mode    => '600',
        source  => 'puppet:///modules/splunk/splunk-search-head-alert_actions.conf',
	}

	exec { '/sbin/service splunk restart':
		refreshonly => true,
		subscribe	=> File['/opt/splunk/etc/system/local/alert_actions.conf'],
	}

	package { "perl-JIRA-Client": ensure => latest }
}

