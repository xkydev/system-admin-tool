function Backup-DirectoryToUSB {
    <#
    .SYNOPSIS
        Backs up a directory to a USB drive with automatic catalog generation.
    
    .DESCRIPTION
        Prompts for source and destination directories, copies all files,
        and generates a detailed catalog file with file names, dates, and sizes.
    
    .EXAMPLE
        Backup-DirectoryToUSB
    #>
    
    Write-Host "`n=== BACKUP DIRECTORY TO USB ===" -ForegroundColor Green
    Write-Host ""
    
    # Get source directory
    $sourceDir = Read-Host "Enter the source directory path to backup"
    
    if (-not (Test-Path $sourceDir)) {
        Write-Host "Error: Source directory does not exist." -ForegroundColor Red
        return
    }
    
    # Display available drives
    Write-Host "`nAvailable drives:" -ForegroundColor Yellow
    $drives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -ne $null }
    foreach ($drive in $drives) {
        $driveInfo = Get-Volume -DriveLetter $drive.Name -ErrorAction SilentlyContinue
        $driveType = if ($driveInfo) { $driveInfo.DriveType } else { "Unknown" }
        Write-Host "  $($drive.Name):\ - $driveType - Free: $(($drive.Free/1GB).ToString('N2')) GB" -ForegroundColor White
    }
    
    Write-Host ""
    $destDrive = Read-Host "Enter the destination USB drive path (e.g., E:\Backup)"
    
    # Create destination directory if it doesn't exist
    if (-not (Test-Path $destDrive)) {
        try {
            New-Item -Path $destDrive -ItemType Directory -Force | Out-Null
            Write-Host "Created destination directory: $destDrive" -ForegroundColor Green
        } catch {
            Write-Host "Error: Cannot create destination directory: $_" -ForegroundColor Red
            return
        }
    }
    
    # Confirmation step
    Write-Host "`n--- CONFIRMATION ---" -ForegroundColor Cyan
    Write-Host "You are about to back up the following directory:"
    Write-Host "  Source:      $sourceDir" -ForegroundColor White
    Write-Host "  Destination: $destDrive" -ForegroundColor White
    Write-Host ""
    
    $confirm = ""
    while ($confirm -notmatch '^[SN]$') {
        $confirm = Read-Host "Do you want to proceed? (S/N)"
    }

    if ($confirm -ne 'S') {
        Write-Host "`nBackup cancelled by user." -ForegroundColor Red
        return
    }

    # Perform backup
    Write-Host "`nStarting backup..." -ForegroundColor Yellow
    Write-Host ""
    
    try {
        # Get all files to backup
        $files = Get-ChildItem -Path $sourceDir -Recurse -File
        $totalFiles = $files.Count
        $copiedFiles = 0
        
        Write-Host "Found $totalFiles files to backup..." -ForegroundColor Yellow
        
        # Copy files with progress
        foreach ($file in $files) {
            $relativePath = $file.FullName.Substring($sourceDir.Length)
            $destPath = Join-Path $destDrive $relativePath
            $destFolder = Split-Path $destPath -Parent
            
            # Create destination folder if needed
            if (-not (Test-Path $destFolder)) {
                New-Item -Path $destFolder -ItemType Directory -Force | Out-Null
            }
            
            # Copy file
            Copy-Item -Path $file.FullName -Destination $destPath -Force
            $copiedFiles++
            
            # Show progress every 10 files or at the end
            if ($copiedFiles % 10 -eq 0 -or $copiedFiles -eq $totalFiles) {
                $percentComplete = [math]::Round(($copiedFiles / $totalFiles) * 100, 2)
                Write-Host "Progress: $copiedFiles/$totalFiles files ($percentComplete%)" -ForegroundColor Cyan
            }
        }
        
        Write-Host "`nBackup completed successfully!" -ForegroundColor Green
        
        # Create catalog file
        $catalogPath = Join-Path $destDrive "backup_catalog.txt"
        Write-Host "`nCreating backup catalog..." -ForegroundColor Yellow
        
        $catalog = @()
        $catalog += "============================================"
        $catalog += "BACKUP CATALOG"
        $catalog += "============================================"
        $catalog += "Backup Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        $catalog += "Source Directory: $sourceDir"
        $catalog += "Total Files Backed Up: $totalFiles"
        $catalog += "============================================"
        $catalog += ""
        $catalog += "{0,-80} {1,-25} {2}" -f "File Name", "Last Modified", "Size (Bytes)"
        $catalog += "{0,-80} {1,-25} {2}" -f "---------", "-------------", "-----------"
        
        foreach ($file in $files) {
            $relativePath = $file.FullName.Substring($sourceDir.Length).TrimStart('\')
            $catalog += "{0,-80} {1,-25} {2}" -f $relativePath, $file.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss"), $file.Length
        }
        
        $catalog | Out-File -FilePath $catalogPath -Encoding UTF8
        
        Write-Host "Catalog created: $catalogPath" -ForegroundColor Green
        Write-Host "`nBackup Summary:" -ForegroundColor Cyan
        Write-Host "  Files copied: $totalFiles" -ForegroundColor White
        Write-Host "  Catalog file: $catalogPath" -ForegroundColor White
        
    } catch {
        Write-Host "Error during backup: $_" -ForegroundColor Red
    }
}
