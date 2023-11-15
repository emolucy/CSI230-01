$B = Get-Content C:\xampp\apache\logs\access.log | Select-String -Pattern ' 200 ' -NotMatch

$regex = [regex]"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

$ips = $regex.Matches($B) | select @{Name="IP"; Expression={ $_.value }}

$counts = $ips | Group-Object IP -NoElement

$countsDetailed = $counts | select Count, Name, @{Name="Decision"; Expression={ if($_.Count -gt 3) {"Abnormal"} else {"Normal"} }}

foreach($ip in $countsDetailed){
    if([string]$ip.Decision -like "Abnormal") {
        Write-Host "Blocking " $ip.Name
        New-NetFirewallRule -DisplayName "Bad IPs $($ip.Name)" -Direction Inbound -Action Block -RemoteAddress $ip.Name
    }
}

Remove-NetFirewallRule -DisplayName "Bad IPs*"