function Find-LargestFiles {
    <#
    .SYNOPSIS
        Finds and displays the 10 largest files on a specified path.
    
    .DESCRIPTION
        Prompts the user for a path to search, then recursively scans
        for files and displays the 10 largest by size.
    
    .EXAMPLE
        Find-LargestFiles
    #>
    
    Write-Host "`n=== FIND LARGEST FILES ===" -ForegroundColor Green
    Write-Host ""
    
    # Display available drives
    Write-Host "Available drives:" -ForegroundColor Yellow
    $drives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -ne $null }
    foreach ($drive in $drives) {
        Write-Host "  $($drive.Name):\ - $($drive.Root)" -ForegroundColor White
    }
    
    Write-Host ""
    $drivePath = Read-Host "Enter the drive or path to search (e.g., C:\ or C:\Users)"
    
    # Validate path
    if (-not (Test-Path $drivePath)) {
        Write-Host "Error: Invalid path specified." -ForegroundColor Red
        return
    }
    
    Write-Host "`nSearching for largest files in '$drivePath'..." -ForegroundColor Yellow
    Write-Host "This may take a few moments..." -ForegroundColor Yellow
    Write-Host ""
    
    try {
        # Get all files recursively, sort by size, and take top 10
        $largestFiles = Get-ChildItem -Path $drivePath -File -Recurse -ErrorAction SilentlyContinue | 
            Sort-Object Length -Descending | 
            Select-Object -First 10
        
        if ($largestFiles.Count -eq 0) {
            Write-Host "No files found in the specified location." -ForegroundColor Yellow
            return
        }
        
        # Display header
        Write-Host ("{0,-10} {1,-20} {2,-40} {3}" -f "Rank", "Size (Bytes)", "File Name", "Full Path") -ForegroundColor Cyan
        Write-Host ("{0,-10} {1,-20} {2,-40} {3}" -f "----", "-----------", "---------", "---------") -ForegroundColor Cyan
        
        $rank = 1
        foreach ($file in $largestFiles) {
            Write-Host ("{0,-10} {1,-20} {2,-40} {3}" -f "#$rank", $file.Length.ToString("N0"), $file.Name, $file.FullName)
            $rank++
        }
        
    } catch {
        Write-Host "Error searching for files: $_" -ForegroundColor Red
    }
}
