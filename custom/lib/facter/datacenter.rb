#
# Provide an additional 'datacenter' fact to use in generic modules to provide datacenter
# specific settings, such as resolv.conf
#
require 'ipaddr'

Facter.add("datacenter") do
    setcode do

        datacenter = "ash1"

        iptmp = Facter.value(:ipaddress_private) || Facter.value(:ipaddress)
        ipnet = IPAddr.new(iptmp)

        ash1net1 = IPAddr.new("10.119.0.0/16")
        officenet1 = IPAddr.new("172.20.104.0/24")

        if ash1net1.include?(ipnet)
            datacenter = "ash1"
        elsif officenet1.include?(ipnet)
            datacenter = "office"
        end

        datacenter
    end
end

Facter.add("syslog_forwarder") do
    setcode do

        syslog_forwarder = "10.177.140.23"

        if $datacenter =~ /^ash1/
            syslog_forwarder = "10.177.140.23"
        elsif  $datacenter =~ /^office/
            syslog_forwarder = "10.177.140.23"
        end
    end
end

