

Get-Service | Where { $_.Status -like "Stopped" } | Sort-Object | Export-Csv -Path StoppedServices.csv -NoTypeInformation