### Admin user keys
class ssh-keys::admins {
    ssh_authorized_key { "bseitz@mgt-jump1.st2.symnds.net":
        name => "bseitz@mgt-jump1.st2.symnds.net",
        user => bseitz,
        ensure => "present",
        type => "ssh-dss",
        key  => 'AAAAB3NzaC1kc3MAAACBAL8igK43DwIBbBnK9uF7NPBBpwZPqlfpN79bUAhTqjpM3oPLUUsNY8/P+1TBd69jlC5m6G0bAvaNCSK3uPVhfhBCGyBbIdAW1fM7eHzxuRJRdKseDIDcClZNF/mT7pGjXkfwwF98WX5TXLzLlKQme5y/ChDAr1ML2lV8FheUtVGFAAAAFQDlQxIAZfemcdn0DTHIDpWYda9Y2QAAAIAzBxHwcoNFn2sTZZeb9VqPLmW8BaE98u0aNqkILP7X6ZCKO4sh36WLlvaoSsp8QxqVdla4fPb4miHJTCiaOofaLjmC6aqsrwV+JLnGmdGgmMlsM9aYRcIqB5LN+jyYIYoCHZKIycB5DT3NLZ3xOa9xXy7yA3TXsg4xmqwjJWz73wAAAIEAksShH5p0rM6Rh8UrWt41YtJnEWcq0r556s2K8/fvYCod3zuqXzjp1OZeDyH8uy0xGiREODKox5nhoV/qvwAS6eSsz9Meep+CAcSkxt8V0JSr/BLhvVdejTfvAcAzeaSiwG9WCBQNKEqjKGGxtLNjPfzCE66Csp2Pm0DfFrQyzGI=',
        require => User["bseitz"],
    }
}

### EOF
