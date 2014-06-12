################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

#Self contained profile - not using tech community module (yet)
class base::ipmi_profile (
  $ensure = "present",
  $ipmiuser = "cpeadmin",
  $ipmipassword = 'Chib9ok_') {

  notice(">>> ipmi_profile.pp <<<")
  notify{"class base::ipmi_profile": }

  if ( $is_virtual != "true" ) {

    #These server IPMI/DRACs are broken
    $install_ipmi = $::fqdn ? {
      "host1.exclude.example.com" => "false",
      default=> "true",
    }
    notify{"DEBUG: install ipmi for $::fqdn is $install_ipmi": }
  
    if ( $install_ipmi == "true" ) {
      Package {
        ensure => $ensure
      }
      case $kernel {
        "Darwin" : {
          debug("no ipmitool package for darwin")
        }
        "Linux" : {
          package { ["ipmitool", "openipmi"] : }
        }
        default : {
          package { "ipmitool" : }
        }
      }
      base::kernel::module {
        ["ipmi_si", "ipmi_devintf", "ipmi_watchdog", "ipmi_msghandler", "ipmi_poweroff"] :
        ensure => $has_ipmi ? {
          "true" => "present",
          default => "absent",
        }
      }
      if $has_ipmi == "true" {
        exec { "ipmi_set_dhcplan" :
          command => "ipmitool lan set ipsrc dhcp",
          onlyif => "test $(ipmitool lan print |grep \"IP Address Source\" |cut -f 2 -d : |grep -c DHCP) -eq 0",
          logoutput => true,
        }
        exec { "ipmi_mod_username" :
          command => "ipmitool user set name 2 ${ipmiuser}",
          onlyif => "test $(ipmitool user list |tail -1 |awk '{print \$2}'|grep -c ${ipmiuser}) -eq 0",
          logoutput => true,
        }
        exec { "ipmi_set_password" :
          command => "ipmitool user set password 2 ${ipmipassword}",
          unless => "test $(ipmitool user test 2 16 ${ipmipassword}",
          logoutput => false,
        }
      }

    } # end if broken IPMI servers
  } else {
    notice(">>> NO ipmi setup on virtual machines <<<")
  } # end of if NOT virtual server

} # end of base::ipmi
