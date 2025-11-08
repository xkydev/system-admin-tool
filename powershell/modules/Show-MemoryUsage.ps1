function Show-MemoryUsage {
    <#
    .SYNOPSIS
        Displays physical memory and virtual memory (page file) usage.
    
    .DESCRIPTION
        Retrieves and displays current memory statistics including
        physical RAM and page file (swap) usage in bytes and percentages.
    
    .EXAMPLE
        Show-MemoryUsage
    #>
    
    Write-Host "`n=== MEMORY AND SWAP USAGE ===" -ForegroundColor Green
    Write-Host ""
    
    try {
        # Get physical memory information
        $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
        $operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem
        
        $totalMemory = $computerSystem.TotalPhysicalMemory
        $freeMemory = $operatingSystem.FreePhysicalMemory * 1KB
        $usedMemory = $totalMemory - $freeMemory
        $memoryPercentUsed = [math]::Round(($usedMemory / $totalMemory) * 100, 2)
        $memoryPercentFree = [math]::Round(($freeMemory / $totalMemory) * 100, 2)
        
        Write-Host "PHYSICAL MEMORY:" -ForegroundColor Cyan
        Write-Host "  Total Memory:       $($totalMemory.ToString('N0')) bytes" -ForegroundColor White
        Write-Host "  Used Memory:        $($usedMemory.ToString('N0')) bytes ($memoryPercentUsed%)" -ForegroundColor White
        Write-Host "  Free Memory:        $($freeMemory.ToString('N0')) bytes ($memoryPercentFree%)" -ForegroundColor Green
        Write-Host ""
        
        # Get page file (swap) information
        $pageFiles = Get-CimInstance -ClassName Win32_PageFileUsage
        
        if ($pageFiles) {
            Write-Host "VIRTUAL MEMORY (Page File/Swap):" -ForegroundColor Cyan
            
            foreach ($pageFile in $pageFiles) {
                $totalPageFile = $pageFile.AllocatedBaseSize * 1MB
                $usedPageFile = $pageFile.CurrentUsage * 1MB
                $freePageFile = $totalPageFile - $usedPageFile
                $pagePercentUsed = if ($totalPageFile -gt 0) { 
                    [math]::Round(($usedPageFile / $totalPageFile) * 100, 2) 
                } else { 
                    0 
                }
                $pagePercentFree = 100 - $pagePercentUsed
                
                Write-Host "  Page File:          $($pageFile.Name)" -ForegroundColor White
                Write-Host "  Total Size:         $($totalPageFile.ToString('N0')) bytes" -ForegroundColor White
                Write-Host "  Used Space:         $($usedPageFile.ToString('N0')) bytes ($pagePercentUsed%)" -ForegroundColor White
                Write-Host "  Free Space:         $($freePageFile.ToString('N0')) bytes ($pagePercentFree%)" -ForegroundColor Green
                Write-Host ""
            }
        } else {
            Write-Host "  No page file configured." -ForegroundColor Yellow
        }
        
    } catch {
        Write-Host "Error retrieving memory information: $_" -ForegroundColor Red
    }
}
