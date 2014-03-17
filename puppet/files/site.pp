# /etc/puppet/manifests/site.pp

import "nodes.pp"

node default {
}

filebucket { main: server => 'puppet.st2.symnds.net' }

# Set global defaults - including backing up all files to the main filebucket and adds a global path
File { backup => false }
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }

