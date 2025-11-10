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
    . (Join-Path $modulesPath "Show-NetworkInfo.ps1")
} catch {
    Write-Host "Error loading modules: $_" -ForegroundColor Red
    Write-Host "Please ensure all module files are in the 'modules' subdirectory." -ForegroundColor Yellow
    exit 1
}

# ============================================================================
# Helper Functions
# ============================================================================
function Wait-ForKeyPress {
    <#
    .SYNOPSIS
        Waits for user to press a key before continuing.
    
    .DESCRIPTION
        Displays a "Press any key to continue" message and waits for user input.
        Compatible with all PowerShell environments (Console, ISE, VS Code).
    
    .EXAMPLE
        Wait-ForKeyPress
    #>
    
    Write-Host "`nPress any key to continue..." -ForegroundColor Gray
    
    # Check if RawUI is available (not available in ISE or some terminals)
    if ($Host.UI.RawUI -and $Host.UI.RawUI.KeyAvailable -ne $null) {
        try {
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        } catch {
            # Fallback to Read-Host if ReadKey fails
            $null = Read-Host
        }
    } else {
        # Fallback for environments without RawUI (like ISE)
        $null = Read-Host
    }
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
        $choice = Read-Host "Enter your choice (1-7)"
        
        switch ($choice) {
            "1" {
                Show-SystemUsers
                Wait-ForKeyPress
            }
            "2" {
                Show-DiskInformation
                Wait-ForKeyPress
            }
            "3" {
                Find-LargestFiles
                Wait-ForKeyPress
            }
            "4" {
                Show-MemoryUsage
                Wait-ForKeyPress
            }
            "5" {
                Backup-DirectoryToUSB
                Wait-ForKeyPress
            }
            "6" {
                Show-NetworkInfo
                Wait-ForKeyPress
            }
            "7" {
                Write-Host "`nExiting... Goodbye!" -ForegroundColor Green
                return
            }
            default {
                Write-Host "`nInvalid choice. Please select 1-7." -ForegroundColor Red
                Start-Sleep -Seconds 2
            }
        }
    } while ($true)
}

# Run the main program
Main
