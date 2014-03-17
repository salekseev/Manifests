$TTL 3600
@                                     3600        IN      SOA     ndsgns1.norton.com.     dl-swap-dcops.symantec.com. (
                                                                  2013072201      ; serial number YYMMDDNN
                                                                  900             ; Refresh
                                                                  600             ; Retry
                                                                  864000          ; Expire
                                                                  3600            ; Min TTL
                                                                  )


;
;  Zone NS records
;
@                                     30                  NS      ndsgns1.norton.com.
@                                     30                  NS      ndsgns2.norton.com.
@                                     30                  NS      ndsgns3.norton.com.


;
;  Zone A records
;
@                                                 IN     MX 10 tus1smtinbpex01.symantec.com.
@                                                 IN     MX 10 tus1smtinbpex02.symantec.com.
@                                                 IN     MX 10 tus1smtinbpex03.symantec.com.
