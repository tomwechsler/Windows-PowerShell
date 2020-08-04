# Installation eines zusätzlichen Domain-Controller

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

Get-Command -Module ADDSDeployment

Install-ADDSDomainController -InstallDns -Credential (Get-Credential DomänenName\administrator) -DomainName DomänenName -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "Passwort" -Force)

