#
# Provide an environment fact based on the 4th character of our standardized hostname structure
#
# https://confluence.symnds.com/display/DOC/NDS+Naming+Convention
#

Facter.add("host_cluster") do
    setcode do
        convention_regex = /^\w{4}\-\w{3}\-\d{3}[[:alpha:]]\d{2}$/
        hname            = Facter.value(:hostname)

        if hname =~ convention_regex
            host_cluster = hname[12].chr
        else
            host_cluster = "a"
        end
        host_cluster
    end
end


Facter.add("host_environment") do
    setcode do
        convention_regex = /^\w{4}\-\w{3}\-\d{3}([[:alpha:]])?\d{2,3}$/
        hname            = Facter.value(:hostname)
        envchar          = hname[0].chr

        if hname =~ convention_regex
            host_environment = case envchar
                when "a" then "all"
                when "b" then "beta"
                when "d" then "dev1"
                when "e" then "dev2"
                when "f" then "dev3"
                when "g" then "dev4"
                when "i" then "infrastructure"
                when "j" then "infrastructuredev"
                when "k" then "backup"
                when "l" then "lab"
                when "o" then "oob"
                when "p" then "production"
                when "q" then "qa1"
                when "r" then "qa2"
                when "s" then "staging"
                when "t" then "qa3"
                when "u" then "uat"
                else "production"
            end
        else
            host_environment = "production"
        end
        host_environment
    end
end

Facter.add("splunk_environment") do
    setcode do
        hname   = Facter.value(:hostname)
        envchar = hname[3].chr
        host_environment = case envchar
            when "a" then "all"
            when "b" then "beta"
            when "d" then "dev1"
            when "e" then "dev2"
            when "f" then "dev3"
            when "g" then "dev4"
            when "i" then "inf"
            when "j" then "infdev"
            when "k" then "backup"
            when "l" then "lab"
            when "o" then "oob"
            when "p" then "prod"
            when "q" then "qa1"
            when "r" then "qa2"
            when "s" then "stage"
            when "t" then "qa3"
            when "u" then "uat"
            else "prod"
        end
        host_environment
    end
end

Facter.add("puppet_master") do
    setcode do
        dcenter = Facter.value(:datacenter)

        puppet_master = case dcenter
            when /ash1/  then "10.119.134.16"
            else "10.119.134.16"
        end
        puppet_master
    end
end

Facter.add("host_role") do
    setcode do
        hname = Facter.value(:hostname)

        host_role = case hname
            when /\-acs/ then "activityconsumer"
            when /\-adm/ then "admin"
            when /\-amq/ then "activemq"
            when /\-atl/ then "atlassian"
            when /\-bld/ then "build"
            when /\-cas/ then "cassandra"
            when /\-cbs/ then "couchbase"
            when /\-com/ then "comm"
            when /\-dld/ then "download"
            when /\-eos/ then "eventservice"
            when /\-gen/ then "generic"
            when /\-had/ then "hadoop"
            when /\-hyp/ then "hypervisor"
            when /\-jci/ then "jenkins"
            when /\-jsl/ then "jslor"
            when /\-mke/ then "rendezvous"
            when /\-mss/ then "multiservice"
            when /\-myq/ then "mysql"
            when /\-nks/ then "keyservice"
            when /\-nmb/ then "mobilebackup"
            when /\-nos/ then "nos"
            when /\-oes/ then "eventservice"
            when /\-ogr/ then "grid"
            when /\-ora/ then "oracle"
            when /\-p2v/ then "p2v"
            when /\-pfs/ then "fileservice"
            when /\-pgq/ then "postgresql"
            when /\-ple/ then "pele"
            when /\-png/ then "pinger"
            when /\-pss/ then "syncservice"
            when /\-rak/ then "riak"
            when /\-rep/ then "report"
            when /\-rmq/ then "rabbitmq"
            when /\-rub/ then "rubber"
            when /\-sbt/ then "salesforce"
            when /\-sca/ then "scalitystorage"
            when /\-scm/ then "scalitymanagement"
            when /\-slg/ then "syslog"
            when /\-spc/ then "spoc"
            when /\-spl/ then "splunk"
            when /\-stj/ then "sevonetojira"
            when /\-tal/ then "talos"
            when /\-tls/ then "webtools"
            when /\-tst/ then "test"
            when /\-van/ then "vanity"
            when /\-www/ then "web"
            else "unknown"
        end
        host_role
    end
end

Facter.add("host_project") do
    setcode do
        hname = Facter.value(:hostname)

        host_project = case hname
            when /^nzo/ then "zone"
            when /^nbu/ then "nobu"
            when /^bfy/ then "backupify"
            when /^apl/ then "apollo"
            when /^nof/ then "nortononlinefamily"
            when /^chr/ then "chronos"
            when /^wdg/ then "watchdog"
            when /^cos/ then "consumer"
            when /^rcn/ then "recon"
            when /^mex/ then "mexico"
            when /^inf/ then "infrastructure"
            when /^ctl/ then "centurylink"
            when /^xen/ then "xenserver"
            when /^whl/ then "whitelabel"
            when /^csf/ then "connectsafe"
            when /^mpl/ then "macplugin"
            else "unknown"
        end
        host_project
    end
end

