################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile
#
# TODO - split this into two subclasses, safe and full
#	safe could be run daily with no customer impact

class base {

  notify{"include base init.pp": }
  notify{"Loading include base OS class": }

  # All flavors of linux
  include base::cron_profile	# latest pkgs, running, perms
# include base::fstab		# Enables managing entries in /etc/fstab
# include base::grub      	# fix TIMEOUT - set to 15s
# include base::ipmi_profile	# ipmitools; modprobe ipmi_devintf ipmi_si
# include base::issue	 	# Authorized Users only Warning
  include base::ldap_profile	# LDAP packages - configuration done by SSSD 
# include base::motd	 	# TBD
  include base::nscd_profile	# hosts only, auth cache with sssd
  include base::ntp_profile	# pkg, service, /etc/ntp.conf
  include base::openssl_profile	# pkgs (incl libssl) latest?	 
  include base::packages_profile # base packages to install/remove
  include base::postfix_profile	# client config
# include base::shell_profile	# global skel, bash, /etc/profile.d/*
# include base::puppet		# puppet agent
  include base::resolv_profile	# manage /etc/resolv.conf
# include base::root		# root values in /etc/passwd and /etc/shadow
# include base::rootkeys	# /root/.ssh/authorized_keys - remove entries
  include base::scheduler_profile # set disk I/O scheduler to deadline
  include base::policy_profile	# disable/remove selinux/apparmor
  include base::limits_profile	# enable updating max open files et. al.
  include base::snmp_profile	# SNMP client ( minimal to enable monitoring )
# include base::ssh		# latest pkgs, manage sshd_config
# include base::sssd	 	# access management	
  include base::sudo_profile	# STOCK clean sudoers, + sudoers.d/default(s)
# include base::sysctl		# Default kernel tuning settings (use hiera)
# include base::sysstat		# enable SAR running every minute???
  include base::services_profile # disable services
  include base::timezone_profile # UTC for all
# include base::tools	  	# scripts and binaries not packaged, part of SV2
  include base::vim_profile 	# come on, its 2014~ and vi still rules

}
# end of include base class
