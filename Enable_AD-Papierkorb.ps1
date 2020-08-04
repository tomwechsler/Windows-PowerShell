#Aktivieren des AD Papierkorbs
Enable-ADOptionalFeature `
–Identity "Recycle Bin Feature" `
–Scope ForestOrConfigurationSet `
–Target "master.pri" `
-Confirm:$False



#Hat es funktioniert?
Get-ADOptionalFeature -Identity "Recycle Bin Feature"




#Die Probe auf's Exemple
Get-ADUser -Identity frabets


Get-ADUser -Identity frabets | Remove-ADUser -Confirm:$False


Get-ADUser -Identity frabets 


Get-ADObject -Filter {Name -like "frabets*"} –IncludeDeletedObjects


Get-ADObject -Filter {Name -like "frabets*"} `
-IncludeDeletedObjects | Restore-ADObject


Get-ADObject -Filter {Name -like "frabets"}