#Installieren der Windows Server Sicherung

Install-WindowsFeature Windows-Server-Backup -IncludeAllSubFeature -IncludeManagementTools


#Sicherung auf eine separate Disk erstellen
Wbadmin start systemstatebackup -backuptarget:E:\ -quiet

#Wiederherstellen von AD DS-Daten
#Löschen eines Benutzer
#Zwischenspeichern des distinguishedName

msconfig => boot => "Safe Boot" => AD Repair
Reboot => .\administrator und password
#CMD öffnen:
wbadmin get versions		(dann die Version identifier: 02/14/2016-14:27 kopieren => nur die ID)
wbadmin start systemstaterecovery -version:02/14/2016-14:27

#WICHTIG: Das ist eine "Nicht autorisierende Wiederherstellung"
#ACHTUNG: noch kein Neustart

#Neues CMD öffnen:

ntdsutil
act inst ntds
authoritative restore
restore object "CN=dpmadmin,CN=Users,DC=lab,DC=int"		(den richtigen DN angeben)
quit
quit

#WICHTIG: msconfig und die Startoptionen wieder zurück setzten
#Und nun im Active Directory und prüfen, dass das Konto wieder vorhanden ist.