class storm::params (

    ### General Configuration
    $storm_nimbus_host        = undef,
    $storm_user               = "storm",
    $storm_group              = "hadoop",
    $storm_is_nimbus          = false,
    $storm_version            = "0.9.1.2.1.1.0-385.el6",
    $storm_supervisor_version = "2.1-8.el6",
    $storm_config_dir_perms   = "0750",

    $storm_log_dir            = "/data/vol1/app/logs/storm",
    $storm_log_dir_link       = "/var/log/storm",
    $storm_log_dir_perms      = "0750",

    $storm_data_dir           = "/data/vol1/storm",
    $storm_data_dir_perms     = "0750",

    ### Nimbus Configuration
    $storm_nimbus_heap_size         = "1024m",
    $storm_nimbus_new_size          = "256m",
    $storm_nimbus_parallelgcthreads = 8,
    $storm_nimbus_jmxremote_port    = 7071,
    $storm_nimbus_jmxetric_version  = "1.0.4",
    $storm_nimbus_jmx_process       = "Nimbus_JVM",

    ### UI Configuration
    $storm_ui_heap_size = "512m",
    $storm_ui_port      = 7070,

    ### Supervisor Configuration
    $storm_supervisor_heap_size         = "512m",
    $storm_supervisor_new_size          = "256m",
    $storm_supervisor_parallelgcthreads = 8,
    $storm_supervisor_jmxremote_port    = 6699,
    $storm_supervisor_jmxetric_version  = "1.0.4",
    $storm_supervisor_jmx_processs      = "Supervisor_JVM",
    $storm_supervisor_slots_ports       = [6700,6701,6702,6703,6704,6705,6706,6707],

    ### Worker Configuration
    $storm_worker_heap_size         = "2048m",
    $storm_worker_new_size          = "256m",
    $storm_worker_parallelgcthreads = 8,
    $storm_worker_jmxetric_version  = "1.0.4",
    $storm_worker_jmx_process       = "Worker_%ID%_JVM",

    ### Zookeeper Configuration - zookeeper_servers must be an array
    $storm_zookeeper_servers = ["localhost"],
    $storm_zookeeper_port    = 2181,
    $storm_zookeeper_root    = "/storm",

    ### Ganglia Configuration
    $storm_ganglia_host            = "localhost",
    $storm_ganglia_nimbus_port     = 8664,
    $storm_ganglia_supervisor_port = 8661,

    ### RPM Configured Parameters - These are here so they can be easily changed if the RPM changes.
    # DO NOT MODIFY unless the RPM changes these parameters.
    $storm_config_dir  = "/etc/storm/conf.dist",
    $storm_install_dir = "/usr/lib/storm",

) {}
