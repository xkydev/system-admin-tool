function Show-DiskInformation {
    <#
    .SYNOPSIS
        Displays information about all filesystems and disks.
    
    .DESCRIPTION
        Retrieves and displays information about all logical drives,
        including total size, free space, and usage percentages.
    
    .EXAMPLE
        Show-DiskInformation
    #>
    
    Write-Host "`n=== DISK INFORMATION ===" -ForegroundColor Green
    Write-Host ""
    
    try {
        # Get all logical drives
        $drives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -ne $null }
        
        if ($drives.Count -eq 0) {
            Write-Host "No drives found." -ForegroundColor Yellow
            return
        }
        
        # Display header
        Write-Host ("{0,-10} {1,-30} {2,-20} {3,-20} {4,-10}" -f "Drive", "Mount Point", "Total Size (Bytes)", "Free Space (Bytes)", "% Free") -ForegroundColor Cyan
        Write-Host ("{0,-10} {1,-30} {2,-20} {3,-20} {4,-10}" -f "-----", "-----------", "------------------", "-------------------", "------") -ForegroundColor Cyan
        
        foreach ($drive in $drives) {
            $totalSize = $drive.Used + $drive.Free
            $freeSpace = $drive.Free
            $percentFree = if ($totalSize -gt 0) { 
                [math]::Round(($freeSpace / $totalSize) * 100, 2) 
            } else { 
                0 
            }
            
            Write-Host ("{0,-10} {1,-30} {2,-20} {3,-20} {4,-10}" -f `
                "$($drive.Name):", `
                $drive.Root, `
                $totalSize.ToString("N0"), `
                $freeSpace.ToString("N0"), `
                "$percentFree%")
        }
        
    } catch {
        Write-Host "Error retrieving disk information: $_" -ForegroundColor Red
    }
}
