require 'facter/util/ip'
require 'resolv'


def has_address(interface)
  ip = Facter::Util::IP.get_interface_value(interface, 'ipaddress')
  if ip.nil?
    false
  else
    true
  end
end

def is_public(interface)
  loopback = Regexp.new('^127.')
  ip = Facter::Util::IP.get_interface_value(interface, 'ipaddress')
  if not is_private(interface) and not loopback.match(ip)
    true
  else
    false
  end
end

def is_private(interface)
  rfc1918 = Regexp.new('^10\.|^172\.(?:1[6-9]|2[0-9]|3[0-1])\.|^192\.168\.')
  ip = Facter::Util::IP.get_interface_value(interface, 'ipaddress')
  if rfc1918.match(ip)
    true
  else
    false
  end
end

def find_networks
  found_public = found_private = false
  Facter::Util::IP.get_interfaces.each do |interface|
    if has_address(interface)
      if is_private(interface)
        found_private = true
      else
        if is_public(interface)
            found_public = true
        end
      end
    end
  end
  [found_public, found_private]
end


# these facts check if any interface is on a public or private network
# they return the string true or false
# this fact will always be present

Facter.add(:on_public) do
  confine :kernel => Facter::Util::IP.supported_platforms
  setcode do
    found_public, found_private = find_networks
    found_public
  end
end

Facter.add(:on_private) do
  confine :kernel => Facter::Util::IP.supported_platforms
  setcode do
    found_public, found_private = find_networks
    found_private
  end
end

# these facts return the first public or private ip address found
# when iterating over the interfaces in alphabetical order
# if no matching address is found the fact won't be present

Facter.add(:ipaddress_public) do
  confine :kernel => Facter::Util::IP.supported_platforms
  setcode do
    ip=""
    Facter::Util::IP.get_interfaces.each do |interface|
      if has_address(interface)
        if is_public(interface)
          ip = Facter::Util::IP.get_interface_value(interface, 'ipaddress')
          break
        end
      end
    end
    ip
  end
end

Facter.add(:ipaddress_private) do
  confine :kernel => Facter::Util::IP.supported_platforms
  setcode do
    ip=""
    Facter::Util::IP.get_interfaces.each do |interface|
      if has_address(interface)
        if is_private(interface)
          ip = Facter::Util::IP.get_interface_value(interface, 'ipaddress')
          break
        end
      end
    end
    ip
  end
end

Facter.add(:ipaddress_lastoctet) do
    setcode do
        last_octet = 0
        ip = Facter.value(:ipaddress)
        last_octet = IPAddr.new(ip).to_s.split('.')[3].to_i

        last_octet
    end
end

Facter.add(:host_gateway) do 
    setcode "ip route | awk '/default/{print $3}'"
end

Facter.add(:gateway_lastoctet) do
    setcode do
        last_octet = 0
        ip = Facter.value(:host_gateway)
        last_octet = IPAddr.new(ip).to_s.split('.')[3].to_i

        last_octet
    end
end
