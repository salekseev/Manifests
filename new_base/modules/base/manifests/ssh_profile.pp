################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

# Using tech community module saz-ssh
class base::ssh_profile {

  notify{"include base ssh_profile.pp": }
  notify{"Loading include base ssh_profile OS class": }

  # Both client and server
  class { 'ssh::client':
  }

  class { 'ssh::server':
      storeconfigs_enabled => false,
      options => {
        'AllowTcpForwarding'     => 'yes',
        'X11Forwarding'          => 'yes',
        'PasswordAuthentication' => 'yes',
        'PermitRootLogin'        => 'yes',
        'Port'                   => '22',
        'Protocol'               => '2',
        'Subsystem'              => 'sftp    /usr/libexec/openssh/sftp-server',
        'SyslogFacility'         => 'AUTHPRIV',
        'PasswordAuthentication' => 'yes',
        'ChallengeResponseAuthentication' => 'no',
        'GSSAPIAuthentication'   => 'yes',
        'GSSAPICleanupCredentials' => 'yes',
        'UsePAM'                 => 'yes',
        'AcceptEnv'              => 'LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION LC_ALL LANGUAGE XMODIFIERS',
      },
  }
} # end of class
