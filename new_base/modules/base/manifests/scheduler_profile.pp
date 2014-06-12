################################################################
#(@) Symantec CPE Base OS configurations
################################################################
# Full include base environment configurations
# https://opswiki.symclab.net/display/CPECIP/Puppet+Consolidated+Base+OS+profile

#Self contained profile - not using tech community module (yet)
class base::scheduler_profile {
  notify{"scheduler.pp": }
  notice(">>> base::scheduler class set disk i/o to deadline <<<")

  $devices = split($::blockdevices,",")
  conf { $devices:; }
  define conf {
    $scheduler = "deadline"
    $device = $name
    notify { "set $device scheduler to $scheduler":; }
    exec { "echo $scheduler > /sys/block/$device/queue/scheduler":
      onlyif => "ls /sys/block/$device/queue/scheduler && fgrep -c -v [$scheduler] /sys/block/$device/queue/scheduler",
    }
  }

}
