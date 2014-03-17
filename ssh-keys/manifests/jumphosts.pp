### Jumphost root SSH keys
class ssh-keys::jumphosts {
    ssh_authorized_key { "root@mgt-jump1.acc4.symnds.net":
        name   => "root@mgt-jump1.acc4.symnds.net",
        user   => root,
        ensure => "present",
        type   => "ssh-dss",
        key    => 'AAAAB3NzaC1kc3MAAACBAJBOUjEOXNLAdr6yw9la47Y/1zMECZLJyQ/hsE8HT0XxWdrTcZxaUj5/OuGLbBW5d42V/fEKVCptEkCjUxA48V7NoLlXEs6GaQCUqJi9u9fntZ37idM3RAniZp8Z83d22ixLIv8xLiigT5mKmM54abtaYu/4957K6N3i/5rvthMfAAAAFQCSGmKjlRfja5EX4ychylgT3a+qdQAAAIAojyVXMl85vB0Z6+zbrY0pvSn5SfgfUL1uv2GH0WXpM5P2UfD/0FHe2Uh5bFgXjV/6RoCgu2iXqd0KcfmQ55PhlmnJdujC+WioOAHVYLAIrc81JZcPCXn89fwG1Q2sbJOk3NjNP8fYI1+5pmFM4v8+WJUsL4mFA1lyDWfB2F0cbQAAAIB73X9/FU4chYvoKhrnod/Y5iF5j1dvhNiO7DkTDjfuRASiGvQsSYaXG12FGD6BXLXDziIPgJypRIIeNquVJQs1fgX6pOeQidA1F7IqTvISt0+gKNNZ0+ioCs1s9Ij1Y/OnpEp0qH1IAvnpLIGybh2yFtcTaHu0C5sHprdPXuhX7Q==',
    }

    ssh_authorized_key { "root@mgt-jump2.acc4.symnds.net":
        name   => "root@mgt-jump2.acc4.symnds.net",
        user   => root,
        ensure => "present",
        type   => "ssh-dss",
        key    => 'AAAAB3NzaC1kc3MAAACBAKcqPXsuNXETCVI+JeAHNtQLhDkuhTrj5OQN20ZgIV0ZXg/dF9CSGnxWJpUxDgXvP9jdj3JWYwriXYGM/tMIIH1/yzyIM07IKJvkp4xOdkkK5ok3ERG9ImqJiIN507SUUpfgeD3Arcj2t8w2bDiCnFQ1iJBw5OewtcHh9qLtJpqnAAAAFQDDHeRrjMGaSgzq8x51jqq9V+IY4QAAAIEAmMv5c81kGcQw9LUpRMZCgHoOVIpX09SIHdX8JtiyEP5J1fQXazyAL0wapEwaQLguzg8WjPXMjoAepobQJLUXkx5pC2NkNk+WfYNk16Kc78HK11jr0oz/buIH+QtWb1USSQAU0SLIJTovPROOhdmZU4rfqMl3u2RUEyJ6yErUSboAAACAJ/lpJWYMVj1OevPbeSw1ncRTSVKjYYOeLkGwNeVdy6w22pyjoVvlKrmndrcct2zknmo0aaTvyFexmPJ4IyybmiWGUjk38NHtafRP6rZF8gobVIINCpUCRM1IFiA83S0gWrEASU74Ks+QsYicS9d5X8ka5ywORKk0BQfqEoyd2Uk=',
    }

    ssh_authorized_key { "root@mgt-jump1.acc5.symnds.net":
        name   => "root@mgt-jump1.acc5.symnds.net",
        user   => root,
        ensure => "present",
        type   => "ssh-dss",
        key    => 'AAAAB3NzaC1kc3MAAACBAOLtQChTVlajNnbhfWTHhnhgBDj6FQ2Qzapx8Un5KqUQJsKFHfrSmCGhSaDKuTX3OKC76FoLq6jzVmPi+bVlW+8oniTH3X9m+ysd0FV2o4OKKA0hMhKl+Jp3mT17yzn6joVWa/fOmBu0shzS+KztJPOe2cubmcwfi992kuuzLEbLAAAAFQD1CIEYJLo3FIsuhTyn4cONG+tufwAAAIBxpBzPGGk/3qqXg79l140oGj8Jo31vWCcR80Y3q6t6hwOJavIDpffqxXy0me6PlXUYnZ1+LAluX+gUnuqeTDnYLzz8LREIYXO2rb3MJiq77IgGMKEkAPT/7Nze0rGNBXU7VipBi/f0zKxHNGR+oXv7wb4hrZEkRalgW+Isjblk9AAAAIEAssxt1bKrxPNez6UlhJmL0mXPUM3DWBSil+XkLIZXYf2zXTXGptYE8RWM0C2u3yHgPtTQ7o2sLFcP9Ot3lpu8Iz1DisSVou0vVyipyYnOf6wUxgRCKcX+yGyUPy2jYk3G7609UVaYShYsaIsZxZbHEPE+x7hKkEC3C3gipn6EQlM=',
    }

    ssh_authorized_key { "root@mgt-jump2.acc5.symnds.net":
        name   => "root@mgt-jump2.acc5.symnds.net",
        user   => root,
        ensure => "present",
        type   => "ssh-dss",
        key    => 'AAAAB3NzaC1kc3MAAACBAK7vGirJKdSsE0Hlqmrswlzi9XSSRG0jpDRp7a8Sb6en/nG3d5YAqOuLecuVGMMESg/S7yeDeb9/Opg6Ok3YJfBQLOzbAD7/Np6jTokJw6PvE3jiZKOEbXqC8ieWfoPvU0qq29lhQT9/L8QwXsgt6m1WaZpIxelEH9BymUo63Rg7AAAAFQCizyATA8d8pZDSXDf0kmEv1PJCBwAAAIEAourDWlXVyJogV1RDFdkeV6yZFTT43DJ76ebgXnoW8eMs9YwrsnL/HV99LFHG3H4N3SFduiGYOvvqMxSddj/peaqsHlXlDZjeB2GFKAqpkvFZf7cIO22llgRhA0Wbc+m5UeZB+EAlmccluTRXBAcszFbk9xXAz4G0HjjaOmPixAkAAACAAclUX0XbOp3BonFIN/Ate+rL5kUR9aKQFyOgccaRohM/WJ/VHqhcqypY2yDhCxW4QIVAxbh+U9Y8oAoCjirpPzObSgtvHPLTfCI/doNByJLpl5dbZty1pND+zKkKRHhYYslr+gnxj0noKKaR+P+5kxlOp2vAFaZ+D5q8CTda+qk=',
    }

    ssh_authorized_key { "root@mgt-jump1.st2.symnds.net":
        name   => "root@mgt-jump1.st2.symnds.net",
        user   => root,
        ensure => "present",
        type   => "ssh-dss",
        key    => 'AAAAB3NzaC1kc3MAAACBAPPIsavwNXxjITmKDrU5uzmSExu2jsHEPJhXZujky/aETOXhw8QU0+FAktPZPsw+OSdALXC7/9zhA2cZvjnX9LCe708E0vtDP61WXaKoBpsDnaVLf3nb+AE5dBK68kxCIh81NGx5pVQIGXwRqt6ka4f9cNtw/OyZfv/EhPyBJYrJAAAAFQDFPJDedFAvjqze31V6aG2mrPdltwAAAIEAuuDEG/doOHg7OcafiTsqgmfSivyUYDkxess46L8wZss3roIIHm9SjL8omEp174v5IGQykOMkXaMNGj0ogzli+8u1HR7Xr92M7LegBM3YdNfhUtZjRKCBUHgUZPVJxDtZNj3R6TSN4h+1pIkddmpXgiHC3LHYkneMdAReqnXdR5kAAACBAKtIrPLR+RJsrzI9ZdDEqOoZUY0btJzG7q2MDy0MoFb/xsz++rQ+5e43marbVdsnyEAm+e8ixKY6zv3ATTfPF9becFq92bIXHgBA98OBZjt7Z/bC3jxB8lLzkRBQ/2dAes/t9xGkjsdlUjRMONvIQx76dASb8EUP5JmGlvGBMS3S',
    }

    ssh_authorized_key { "root@mgt-jump2.st2.symnds.net":
        name   => "root@mgt-jump2.st2.symnds.net",
        user   => root,
        ensure => "present",
        type   => "ssh-dss",
        key    => 'AAAAB3NzaC1kc3MAAACBAKt376pRYAoK242uJbv6QOeZklspt7ZsAnRL9VLp/zPdq6s/nK54cLZvuzyUohb6cD4MLjG1yJkOhWrOf/pcni3H5ajlQfk4FoWDKlAdLedcavhujFd7duRiG8izNF0Ya0LDZp9enm1C1eiA3vBKCOdqKnKlS7duHsSHyuUrnXffAAAAFQCvgt8Mtsu6TpmPxm2OWouDc4K62wAAAIAhhBfMkB+7YyX6ELU30YfC+gE6U2CvEitDqEXictLWioXPOKkQbvRYWvecfLztT88d6DbgMgDxBCXRNRqRk+uBrzEObFPPeQl5kfTMG9N7vPeLRwYj/fi7j+kV1ophaxxaKvlQWV4M3d6HNXbloqMDI2hxxn7TKyDjtFleww4CdgAAAIEAhCRuZFYbJK+0RshWLmlP6HzNg8xkh5UR4YLrD5Bhn42uHO3KimV8BGvjlpjoMe8a8U3xeuT7C9Vy/tBLllJLoRtKNw71qb8SnPPL6noNuRAO0gOUGkfi8je6DuhJcrQsGcJQMqHYnGXawogXKF/o8Z0I2UbF9gDx/5N22/I/7nU=',
    }

    ssh_authorized_key { "root@llinjpash10001.mgmt.symcpe.net":
        name   => "root@llinjpash10001.mgmt.symcpe.net",
        user   => root,
        ensure => "present",
        type   => "ssh-dss",
        key    => 'AAAAB3NzaC1kc3MAAACBANTRbpdeN0ykkovAawAF09V6gguBtI02t1tNlyNYIU1mP4oE8TPmFc26JHOtd1UXtVrkNITGJEO1IUf2I/V9isZ0cdPGqZc2pGqinDOeg7XE1JoSQSc2wLIAzPxIFbtLqdQtytE5iWA8TBpWhrNE6sntw7uOZo6x/aTh5yE9GrEvAAAAFQC3leEQ0mAJsCcpi7xnyQBxYQQgpQAAAIARI2Pswq+EZwbiLye9hURNSsNW7Na3x4m8tvXL/4Umznjn/6bb1gCFWAcJu8AhagGP+ApLJkbO3uoNczgH5Y9XMWWjMbadq4lhPAWIwaBSj1mZSCE2axTMlQnaqd3vv9ejLxN29RBST1Ih49DC+H62kjxLeD1AfGwbV1rlTVeIpwAAAIAhDAGC9qv/bbzDWH5QFl2glYt1ljt0QrhGcOV2Jz4j5w+3gncwNwKe5Bv1urbPWmuuIdN2XkEGc1c3atFv+6+DDFLYlL4KM0Rsw5B7v+jw8TtKsGKfF2qv7ZslbgnWOiWuCrmLcKF7fyCYjNgM0QleBnTQ1pbum9mC/SgwMmO4XA==',
    }

    ssh_authorized_key { "root@llinjpash10002.mgmt.symcpe.net":
        name   => "root@llinjpash10002.mgmt.symcpe.net",
        user   => root,
        ensure => "present",
        type   => "ssh-dss",
        key    => 'AAAAB3NzaC1kc3MAAACBAJNqmlzPUYA0lG+v2q86aIHCpQMsNSPDjR/QAw8LrR+Lkv9EjJgVtVG8o8w2iAd8cPtfo/2xVPJd4C0KqL+VJvd7LajMpK7Xs4oVAWUorvkQWleet/2Mi0JDNtOAJLBOwrRA3hJIj3ErEEl59V1eg3jqPB5LN3tY1myNN3nJsYuJAAAAFQCzP/z5RALbcJQCYgrtMsa/iSFWNwAAAIBHVe6WbhKjrmHrxqSjLFKqD/9CpPWSNMEFZi0l8XjIoX/3kUh5V5tO1hC7FM16noU8hWFEUrcjrI1Q4SJuulrneqzxZay66lm9raG/U+Ga8SnksgoYwf60B4nYE9S4kr3dNqx30496GxNyOAyImV7TVE2TazIaaIV045DBvsO7GQAAAIA+NWj3ZLCX4nfluaW88bpQdyqAXr8vXXN9Pa7l2Ym9DJThEHvmfhg0gCn8EDW1F9W2wJ042DgDwZSl2NtOalmIWx2tIkm0mJ8q0CAqSJ6FjfELhGgVeaqizsQBkg3mhbYt0CeTgFMtDWRnvits2Z+kb+BCRaLBg5X64sCakr1y/g==',
    }

    ssh_authorized_key { "root@Symantec-C02HG03NF0V2":
        name   => "root@Symantec-C02HG03NF0V2",
        user   => root,
        ensure => "present",
        type   => "ssh-rsa",
        key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDHguMxaalGmJ8YcNHuB9Pf1k/Lrui7m01dsfGMRESc30bXBTYXr4rMuQ7qNCTQ7R2uHxfMzAVGtOlUCnH9nH9lsnlMId7W7OFko4G5M5uBUmAvyexoisn17bAdcSeJU+urOnIK1VI5N0WO67OwJhd/Rqqbnx+1RsjBVb3WO65a3RDu02dgHDeafXhVWfvubGej/3NEf6U+2P7CI/TkQgjWtpUuiI3OcsAxIYeHyvu8vYMKuJ18baoUsW5dsGbpnJmf9dt0j801EJrWti1bJYULABcTm/r8VnqNv46TQ/aGKV+zaxN2hOzyWxHsPfUrNWnvUnXsVowQCTjvt3HlBn2t',
    }
}

### EOF
