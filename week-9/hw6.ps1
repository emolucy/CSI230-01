$chrome = Get-Process | Where { $_.ProcessName -eq "Chrome" } | Select Id, ProcessName, StartTime

if($chrome -ne $null){
    Write-Host "Closing Chrome..."
    
    Stop-Process -Name "Chrome"
}
else{
    Write-Host "No instance of chrome found. Starting..."

    Start-Process 'C:\Program Files\Google\Chrome\Application\chrome.exe' 'https://champlain.edu'
}