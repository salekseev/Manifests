require 'rubygems'
require 'net/https'
require 'json'
require 'open-uri'
require 'erb'
require 'facter'
require 'socket'

################################################################################
################################################################################
module ITOP_Facts
    ############################################################################
    ############################################################################
    class ItopClient
        public
        ########################################################################
        ########################################################################
        attr_reader :username, :password, :host, :url, :headers, :request

        ########################################################################
        ########################################################################
        def initialize(host, username, password)
            @host = host
            @username = username
            @password = password
            @url = init_url()
            @headers = init_headers()
            @request = init_request()
        end
        
        ########################################################################
        ########################################################################
        def init_url
            return URI.parse("https://#{@host}/webservices/rest.php?version=1.1")
        end

        ########################################################################
        ########################################################################
        def init_headers
            return { 'Content-type' => 'application/json', 'Accept' => 'application/json' }
        end
        
        ########################################################################
        ########################################################################
        def init_request
            return { 'version' => '1.1', 'auth_user' => @username, 'auth_pwd' => @password }
        end

        ########################################################################
        ########################################################################
        def request_string
            str = ''
            sep = ''
            @request.each do |k,v|
                str += '&' + ERB::Util.url_encode(k) + '=' + ERB::Util.url_encode(v)
            end
            return str[1 .. -1]
        end

        ########################################################################
        ########################################################################
        def request(json_data={})
            @request['json_data'] = json_data
            @url.query = self.request_string
            @url.open do |req|
                if req
                    return req.read()
                end
            end
            return nil
        end
    end
end

################################################################################
################################################################################
module Facter::Util::ITOP_Facts
    @cache_location='/var/lib/puppet/.itop_facts_cache'
    username='bryan_seitz'
    password='YbHo3v'
    hostname = 'itop.symcpe.net'
    
    ############################################################################
    ############################################################################
    def self.get_fqdn                                                           # cannot use other facts from within a fact, because they may not have been populated yet
        possible_fqdn = []
        possible_fqdn << `/bin/hostname -f 2>/dev/null`.chomp
        possible_fqdn << `/bin/hostname 2>/dev/null`.chomp

        begin
            possible_fqdn << Socket.getaddrinfo(Socket.gethostbyname(Socket.gethostname).first, 'http').sort { |l, r| r[2].size <=> l[2].size }[0][2]
        rescue
        end

        return possible_fqdn.sort { |l, r| r.size <=> l.size }[0]
    end

    ############################################################################
    ############################################################################
    def self.read_cache
        data_string = nil
        begin
            open(@cache_location, 'r') do |fd|
                if fd
                    data_string = fd.read()
                end
            end
        rescue
        end
        return data_string
    end

    ############################################################################
    ############################################################################
    def self.write_cache(str)
        begin
            open(@cache_location,'w') do |fd|
                fd.write(str)
            end
        rescue
            raise
        end
        return
    end

    ############################################################################
    ############################################################################
    itop = ITOP_Facts::ItopClient.new(hostname, username, password)
    data_string = nil
    cached = false

    begin
        data_string = itop.request(JSON.dump({'operation'=> 'core/get', 'class' => 'Server','key' => "SELECT Server WHERE FQDN = '#{self.get_fqdn}'"}))
    rescue
    end

    if data_string == nil
        data_string = read_cache
        cached = true
    end

    if data_string != nil
        begin
            data = JSON.load(data_string)
        rescue
        end
    end

    unless data and data['objects'] and data['objects'].keys().size > 0
        data_string = read_cache
        data = JSON.load(data_string)
        cached = true
    end

    if data
        if !cached 
            write_cache(data_string)
        end
        
        objects = data['objects']
        first=objects.keys[0]

        objects[first]['fields'].each do |k, v|
            next if k.start_with?('itop_')
            if v.class == Hash or v.class == Array
                Facter.add("itop_#{k}") { setcode { JSON.dump(v) } }
            else
                Facter.add("itop_#{k}") { setcode { String(v) } }
            end
        end
    end
end


