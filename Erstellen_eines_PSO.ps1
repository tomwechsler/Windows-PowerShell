#Neue OU für die Fuehrungskräfte
New-ADOrganizationalUnit CFO

#Und eine eine Gruppe
New-ADGroup -Name "Fuehrungskraefte" `
-GroupScope Universal `
-Description "Fuehrungskraefte von Corp.int" `
-GroupCategory "Security" `
-Path "OU=CFO,DC=corp,DC=int" `
-SAMAccountName "Fuehrungskraefte" `
-PassThru

#Neuer CFO braucht einen Account
New-ADUser -Name "Erika Meister" `
-GivenName "Erika" `
-SurName "Meister" `
-Department "Finance" `
-Description "Chief Financial Officer" `
-ChangePasswordAtLogon $True `
-EmailAddress "Meister@corp.int" `
-Enabled $True `
-PasswordNeverExpires $False `
-SAMAccountName "Meister" `
-AccountPassword (ConvertTo-SecureString "Starting P@ssw0rd!" `
-AsPlainText `
-Force) `
-Title "Chief Financial Officer" `
-PassThru

#Dieser Account ist Mitglied der neuen Gruppe
Add-ADPrincipalGroupMembership -Identity Meister `
-MemberOf "Fuehrungskraefte" `
-PassThru

#Jetzt erstellen wir ein PSO
New-ADFineGrainedPasswordPolicy `
-description:"Minimum12 Zeichen fuer alle Fuehrungskraefte." `
-LockoutDuration 00:10:00 `
-LockoutObservationWindow 00:10:00 `
-LockoutThreshold 5 `
-MaxPasswordAge 65.00:00:00 `
-MinPasswordLength 12 `
-Name:"Fuehrungskraefte Pwd Policy" `
-Precedence 10 `
-PassThru

#Diese neue PSO setzten wir auf die neue Gruppe an
Get-ADGroup -Identity "Fuehrungskraefte" `
| Add-ADFineGrainedPasswordPolicySubject `
-Identity "Fuehrungskraefte Pwd Policy"

#Und schauen ob es funktioniert hat => Kontrolle kann auch im AD Verwaltungscenter gemacht werden
Get-ADFineGrainedPasswordPolicySubject -Identity "Fuehrungskraefte Pwd Policy"