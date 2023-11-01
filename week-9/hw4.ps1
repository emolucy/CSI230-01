cd "C:\Users\champuser\CSI230-01\week-9"

Get-ChildItem | Where { $_.Extension -like ".ps1" } | Sort-Object -Property CreationTime