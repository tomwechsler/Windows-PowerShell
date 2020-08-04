# Neue virtuelle Disk hinzufügen

Set-Location c:\
Clear-Host

#Remote Session
Enter-PSSession -ComputerName dcsrv01

# Die neue Disk bearbeiten
Get-Disk

Set-Disk -Number 1 -IsOffline $false

Get-Disk

Initialize-Disk -Number 1 -PartitionStyle GPT

New-Partition -DiskNumber 1 -UseMaximumSize -AssignDriveLetter

Format-Volume -DriveLetter E -FileSystem NTFS

# Installieren der Windows Server Sicherung und erstellen eines Backup-Jobs
get-windowsfeature *windows-server*

install-windowsfeature -name Windows-Server-Backup -includ -allsub

gcm -Module windowsserverbackup

$policy = new-wbpolicy

$policy

add-wbsystemstate -policy $policy

$policy

get-wbvolume -allvolumes

get-wbvolume -allvolumes | where mountpath -EQ "c:"

$volume = get-wbvolume -allvolumes | where mountpath -EQ "c:"

add-wbvolume -policy $policy -Volume $volume

$policy

get-wbvolume -allvolumes

get-wbvolume -allvolumes | where mountpath -EQ "e:"

$backupvolume = get-wbvolume -allvolumes | where mountpath -EQ "e:"

$backuptarget = new-wbbackuptarget -volume $backupvolume

add-wbbackuptarget -policy $policy -Target $backuptarget

$policy

set-wbschedule -policy $policy -Schedule 03:00

$policy

# Wir wollen aber das Backup gleich jetzt starten
set-wbpolicy -policy $policy

start-wbbackup -policy $policy