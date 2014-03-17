### Puppeteer host key
class ssh-keys::puppeteer {

    ssh_authorized_key { "root@mgt-puppet1.st2.symnds.net":
        name   => "root@mgt-puppet1.st2.symnds.net",
        user   => root,
        ensure => "present",
        type   => "ssh-dss",
        key    => 'AAAAB3NzaC1kc3MAAACBAMPGAbY+u3ptyLPIiQ1xAsZ7Vl+vVIwFedvmpOTMk4+02UcwGBwpVsvj5Lj6mpSsT1ydneG3MZYTRYz7IMlPj9Tfmo53FsCiOXrg41iQ0jH6JutNaZgm5bOMAj2CG2OLwWvOIHBDUz3LPkzvmHFeAlHcf5jfwcwL4jI0133BKY7BAAAAFQDgy4CFmrFP8it9e+ueMUn+OR4lcwAAAIAF5PCEjDSKrr1kf2bzUU4i1EZbTSVtn7u84ulSu0sZX95uAQH8HpzfeyjVe1xOsFRQLKZtdBYQ8jA6Sxs7N51L0EaER9TebBlhUfab7P/t/qtMBwdqhyCp/magf6bVWDupuFGXqV2utbYbYf4HouPF2c2D+hdAzpYlcnziZyTmuwAAAIAnH9m3thDpLybGje1L2yu+x7Rf8OuR3hZhkg3Gyyeo7DHqSzZIZ0JXJXIYgVp6LXNoHgEN/N6iQuSF0w+x38RzYrybQPyxw4AulUjhbwHFqYxZiMpfOp5OsvD+OIRgpRDeSEsYfu1R7Dl9a+WiPQcltxAWAKeWMHPJNHlvDsTcwA==',
    }
}

### EOF
