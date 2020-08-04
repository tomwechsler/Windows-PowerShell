#Der erste Schritt, den Root Key erstellen

#Dieser Befehl im produktivem Umfeld einsetzen (Wichtig 10h warten - Replikation)
Add-KdsRootKey -EffectiveImmediately

#Dieser Befehl ist für eine Testumgebung gedacht 
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10)) 

#Ich erstelle eine neue Gruppe
New-ADGroup -Name TestMSA `
-GroupScope DomainLocal `
-Description "Gruppe fuer Server von TestMSA" `
-DisplayName "Test gMSA Gruppe" `
-GroupCategory Security `
-SAMAccountName TestMSA `
-PassThru

#Dieser Gruppe füge ich nun die "Members" hinzu
Add-ADGroupMember -Identity TestMSA `
-Members "dcsrv01$","dcsrv02$" `
-PassThru

#Kontrolle
Get-ADGroupMember -Identity TestMSA

#Nun erstelle ich einen neuen Account
New-ADServiceAccount -Name SvcAcnt1 `
-DNSHostName SvcAcnt1.corp.int `
-PassThru

#Der Account wird nun bearbeitet
Set-ADServiceAccount -Identity SvcAcnt1 `
-PrincipalsAllowedToRetrieveManagedPassword TestMSA `
-PrincipalsAllowedToDelegateToAccount TestMSA `
-PassThru

#Vor dem ausführen dieses cmdlets müssen die Systeme neugestartet werden (damit Gruppenzugehörigkeit übernommen wird)
Invoke-Command -ComputerName dcsrv02 -ScriptBlock {Restart-Computer -Force}

#Ich installiere den Service Account auf dem DCSRV02
Invoke-Command -ComputerName dcsrv02 -ScriptBlock {Install-ADServiceAccount -Identity SvcAcnt1}

#Kontrolle
Invoke-Command -ComputerName dcsrv02 -ScriptBlock {Test-ADServiceAccount -Identity SvcAcnt1}

#Jetzt können wir in den Diensten diesen Account für einen spezifischen Dienst auswählen