cd "C:\Users\champuser\CSI230-01\week-9"

$date = Get-Date("10/25/2023")

Get-ChildItem | Where { $_.CreationTime -gt $date } | Select-Object Name, CreationTime | Export-Csv -NoTypeInformation -Path .\outfolder\newfiles.csv