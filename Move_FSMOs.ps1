$Server = Get-ADDomainController -Identity "SRV2019-01"

Move-ADDirectoryServerOperationMasterRole -Identity $Server -OperationMasterRole SchemaMaster,DomainNamingMaster,PDCEmulator,RIDMaster,InfrastructureMaster