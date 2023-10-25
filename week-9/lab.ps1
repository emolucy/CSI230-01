# Get IPv4 Address from Ethernet Interface
(Get-NetIPAddress -AddressFamily IPv4 | where InterfaceAlias -ilike "ethernet[0-9]").IPAddress

# Get IPv4 PrefixLength from Ethernet Interface
(Get-NetIPAddress -AddressFamily IPv4 | where InterfaceAlias -ilike "ethernet[0-9]").PrefixLength

Get-WmiObject -list | where { $_.Name -ilike "Win32_Net*" } | Sort-Object

Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" `
| Select DHCPServer | Format-Table -HideTableHeaders

(Get-DnsClientServerAddress -AddressFamily IPv4 | `
Where InterfaceAlias -ILike "Ethernet[0-9]").ServerAddresses[0]

cd "C:\Users\champuser\CSI230-01\week-8"

$files=(Get-ChildItem)
for($j=0; $j -le $files.Count; $j++){
    if($files[$j].Extension -ilike "*ps1"){
        $files[$j].BaseName+$files[$j].Extension
    }
}

$folderPath = "C:\Users\champuser\CSI230-01\week-9\outfolder"
if(Test-Path $folderPath){
    Write-Host "Folder Already Exists"
}
else{
    New-Item -ItemType Directory -Path $folderPath
}

#10
cd "C:\Users\champuser\CSI230-01\week-9"
$files=(Get-ChildItem)

$folderPath = "C:\Users\champuser\CSI230-01\week-9\outfolder\"
$filePath = Join-Path $folderPath "out.csv"

$files | Where-Object { $_.Extension -like ".ps1" } | `
Export-Csv -Path $filePath

#11
$files= Get-ChildItem -File -Recurse
$files | Rename-Item -NewName { $_.Name -replace '.csv', '.log' }
Get-ChildItem -Recurse -File