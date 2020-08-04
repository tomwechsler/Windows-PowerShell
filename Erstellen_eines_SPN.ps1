#Für den SPN, den Erstellten Service-Account "SVCACC" verwenden
#Eigenschfaten zeigen vom "SVCACC" und darauf aufmerksam machen, dass das Register Delegation fehlt.

setspn -s http/app1.corp.int filesrv01

setspn -s http/app2.corp.int corp\svcacc

#Jetzt kann auf dem Konto svcacc in den Eigenschaften das Register Delegation ausgewählt werden
