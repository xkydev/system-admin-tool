# Get the script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$modulesPath = Join-Path $scriptPath "modules"

# Import all modules
try {
    . (Join-Path $modulesPath "Show-Menu.ps1")
    . (Join-Path $modulesPath "Show-SystemUsers.ps1")
    . (Join-Path $modulesPath "Show-DiskInformation.ps1")
    . (Join-Path $modulesPath "Find-LargestFiles.ps1")
    . (Join-Path $modulesPath "Show-MemoryUsage.ps1")
    . (Join-Path $modulesPath "Backup-DirectoryToUSB.ps1")
} catch {
    Write-Host "Error loading modules: $_" -ForegroundColor Red
    Write-Host "Please ensure all module files are in the 'modules' subdirectory." -ForegroundColor Yellow
    exit 1
}

# ============================================================================
# Main Program Loop
# ============================================================================
function Main {
    <#
    .SYNOPSIS
        Main program loop for the System Administration Tool.
    
    .DESCRIPTION
        Displays the menu and handles user input, calling the appropriate
        module function based on the user's selection.
    #>
    
    do {
        Show-Menu
        $choice = Read-Host "Enter your choice (1-6)"
        
        switch ($choice) {
            "1" {
                Show-SystemUsers
                Write-Host "`nPress any key to continue..." -ForegroundColor Gray
                $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            }
            "2" {
                Show-DiskInformation
                Write-Host "`nPress any key to continue..." -ForegroundColor Gray
                $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            }
            "3" {
                Find-LargestFiles
                Write-Host "`nPress any key to continue..." -ForegroundColor Gray
                $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            }
            "4" {
                Show-MemoryUsage
                Write-Host "`nPress any key to continue..." -ForegroundColor Gray
                $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            }
            "5" {
                Backup-DirectoryToUSB
                Write-Host "`nPress any key to continue..." -ForegroundColor Gray
                $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            }
            "6" {
                Write-Host "`nExiting... Goodbye!" -ForegroundColor Green
                return
            }
            default {
                Write-Host "`nInvalid choice. Please select 1-6." -ForegroundColor Red
                Start-Sleep -Seconds 2
            }
        }
    } while ($true)
}

# Run the main program
Main
