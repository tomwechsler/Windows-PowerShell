#Das Konto des zu klonendem System muss in die Gruppe "Klonbare Domänencontroller"



#Diese Tools müssen zuerst deinstalliert werden oder in die Liste der Ausnahmen hinzugefügt werden
Get-ADDCCloningExcludedApplicationList



#Diese Liste wird nun mit einer neue XML Datei in den entsprechenden Pfad "abgelegt"
Get-ADDCCloningExcludedApplicationList -GenerateXML -Path C:\Windows\ntds



#Mit dem folgendem cmdlet starte ich einen Test. Ist der Test erfolgreich habe ich eine Datei in c:\windows\ntds\DCCloneConfig.xml
New-ADDCCloneConfigFile



#Auszug aus der Hilfe
New-ADDCCloneConfigFile [-CloneComputerName <Zeichenfolge>] [-IPv4DNSResolver<Zeichenfolge[]>] [-Path <Zeichenfolge>] [-SiteName <Zeichenfolge>]
