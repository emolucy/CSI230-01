cd C:\Users\champuser\Desktop

clear

Get-EventLog -list

$readLog = Read-Host -Prompt "Please select a log to review"

Write-Host "Exporting csv..."

$exportPath = "C:\Users\champuser\Desktop\rep.csv"

Get-EventLog -LogName $readLog | Export-Csv -NoTypeInformation -Path $exportPath

Write-Host "Exported to $exportPath"