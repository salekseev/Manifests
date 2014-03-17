$TTL 1D
@                                     3600        IN      SOA     ns1.st2.symnds.net.     dl-swap-dcops.symantec.com. (
                                                                  2012092702      ; serial number YYMMDDNN
                                                                  28800           ; Refresh
                                                                  7200            ; Retry
                                                                  864000          ; Expire
                                                                  366666600       ; Min TTL
                                                                  )


;
;  Zone NS records
;

@                                     43200               NS      ns1.st2.symnds.net.
@                                     43200               NS      ns2.st2.symnds.net.
  

;
;  Zone A records
;

localhost                                         IN      A       127.0.0.1
@						  IN	  A	  63.245.201.72
WWW						  IN	  A	  63.245.201.72
ZPI						  IN	  A	  63.245.201.74

