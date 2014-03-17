class yum::mirror {
    ### Add master mirror root key for rsync
    include ssh-keys::master_mirror

    ### NGINX Parameterized class
    class { 'nginx':
        nginx_conf_autoindex => 'on',
        nginx_conf_path      => 'nginx/nginx.conf.download.erb',
        nginx_web_root       => '/var/www',
        nginx_version        => latest,
        nginx_worker_procs   => '4',
        nginx_worker_conns   => '1024',
    }
}
