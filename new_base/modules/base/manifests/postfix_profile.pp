################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

# Using tech community module thias-postfix
class base::postfix_profile (
  $smtprelay = 'smtp.symcpe.net',
  $smtpdomain = 'symcpe.net',
  $smtpprivnetworks = '127.0.0.1 172.16.0.0/16 10.0.0.0/16 192.168.0.0/16',
  $smtpsymnetworks = '10.50.0.0/16 10.116.1.0/24 10.119.135.0/24 10.119.134.0/24') {

  notify{"include base postfix_profile.pp": }
  notify{"Loading include base postfix_profile OS class": }

  #TODO override for smtp servers - use networks above
  # using thias-postfix
  class { '::postfix::server':
    extra_main_parameters => {
      "${config_directory}/main.cf" => {
        content => template("base/postfix/main.cf.erb"),
      },
    },
  }

} # end of class
