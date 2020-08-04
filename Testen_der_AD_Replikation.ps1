repadmin /showrepl

repadmin /replsummary

repadmin /kcc

repadmin /syncall /force /aped

repadmin /showconn corp.int

dcdiag /test:replications

Update-DfsrConfigurationFromAD -ComputerName dcsrv01

Get-ADDomainController -Server dcsrv01 -Filter * | ForEach-Object { Update-DfsrConfigurationFromAD $_.Name -verbose }

Get-ADDomainController -Filter * | Format-Table Name, Domain, Forest, Site, IPv4Address, OperatingSystem, OperationMasterRoles -AutoSize


Read-Host "Enter the user account to unlock" | Unlock-ADAccount

Set-ADAccountPassword (Read-Host 'User') -Reset

Get-ADDomainController -Server dcsrv01 -Filter * | ForEach-Object {Get-WmiObject -Class win32_logicaldisk -ComputerName $_.name | ft systemname,deviceid,freespace -AutoSize}

get-addomain | fl *
get-adforest | fl *