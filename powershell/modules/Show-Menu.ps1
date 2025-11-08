function Show-Menu {
    <#
    .SYNOPSIS
        Displays the main menu for the System Administration Tool.
    
    .DESCRIPTION
        Clears the screen and displays a formatted menu with all
        available options for the system administration tool.
    
    .EXAMPLE
        Show-Menu
    #>
    
    Clear-Host
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "   SYSTEM ADMINISTRATION TOOL (Windows)" -ForegroundColor Cyan
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Display System Users" -ForegroundColor Yellow
    Write-Host "2. Display Filesystem/Disk Information" -ForegroundColor Yellow
    Write-Host "3. Find Largest Files" -ForegroundColor Yellow
    Write-Host "4. Memory and Swap Usage" -ForegroundColor Yellow
    Write-Host "5. Backup Directory to USB" -ForegroundColor Yellow
    Write-Host "6. Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
}
