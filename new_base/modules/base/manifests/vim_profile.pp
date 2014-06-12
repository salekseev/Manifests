################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

# Using tech community module saz-vim
class base::vim_profile {

  notify{"include base vim_profile.pp": }
  notify{"Loading include base vim_profile OS class": }

  class { 'vim':
    #opt_syntax => 'true',
    #set_as_default => 'true',
    ensure => 'present',
    opt_misc => ['nohlsearch','noshowcmd','noshowmatch','noignorecase','nosmartcase','noincsearch','noautowrite','nohidden','nonumber'],
  }
} # end of class
