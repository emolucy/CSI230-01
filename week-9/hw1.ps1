$time = Get-Date
$startTime = $time.AddHours(-1)

Get-Process | Where { $_.StartTime -gt $startTime } | Where { $_.ProcessName -like "C*" }