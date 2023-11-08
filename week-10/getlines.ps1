cd "C:\Users\champuser\CSI230-01"

$files = Get-ChildItem -Recurse -Filter *.bash

$counts = @()

for ($i = 0; $i -lt $files.Count; $i++) {
    $counts += Get-Content $files[$i].FullName | Measure-Object -Line -Word
}

Write-Host "Average Line Count: " ($counts | Measure-Object -Property Lines -Average).Average

Write-Host "Average Word Count: " ($counts | Measure-Object -Property Words -Average).Average

Write-Host "Max Line Count: " ($counts | Measure-Object -Property Lines -Maximum).Maximum

Write-Host "Max Word Count: " ($counts | Measure-Object -Property Words -Maximum).Maximum

Write-Host "Min Line Count: " ($counts | Measure-Object -Property Lines -Minimum).Minimum

Write-Host "Min Word Count: " ($counts | Measure-Object -Property Words -Minimum).Minimum