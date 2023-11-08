

Write-Host "Choose which service type to view"

$block = {
    $choice = Read-Host "Please enter an option (all) (stopped) (running) (quit)"

    if ($choice -eq "all" -or $choice -eq "stopped" -or $choice -eq "running" -or $choice -eq "quit") {
        $choice
    }
    else {
        Write-Host "Invalid Input" 
        & $block
    }
}

while ($true) {
    $input = & $block

    if ($input -eq "quit") {
        Write-Host "Goodbye"
        break
    }

    if ($input -eq "stopped") {
        Get-Service | Where-Object { $_.Status -eq "Stopped" }
    }
    elseif ($input -eq "running") {
        Get-Service | Where-Object { $_.Status -eq "Running" }
    }
    else {
        Get-Service
    }
}



