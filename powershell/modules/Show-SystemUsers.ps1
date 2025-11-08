function Show-SystemUsers {
    <#
    .SYNOPSIS
        Displays all local user accounts with last login information.
    
    .DESCRIPTION
        Retrieves and displays all local user accounts on the system,
        including their enabled status and last login date/time.
    
    .EXAMPLE
        Show-SystemUsers
    #>
    
    Write-Host "`n=== SYSTEM USERS ===" -ForegroundColor Green
    Write-Host ""
    
    try {
        # Get all local user accounts
        $users = Get-LocalUser | Sort-Object Name
        
        if ($users.Count -eq 0) {
            Write-Host "No users found on the system." -ForegroundColor Yellow
            return
        }
        
        # Display header
        Write-Host ("{0,-25} {1,-20} {2,-30}" -f "Username", "Enabled", "Last Login") -ForegroundColor Cyan
        Write-Host ("{0,-25} {1,-20} {2,-30}" -f "---------", "-------", "----------") -ForegroundColor Cyan
        
        foreach ($user in $users) {
            $lastLogin = if ($user.LastLogon) { 
                $user.LastLogon.ToString("yyyy-MM-dd HH:mm:ss") 
            } else { 
                "Never logged in" 
            }
            
            $enabled = if ($user.Enabled) { "Yes" } else { "No" }
            
            Write-Host ("{0,-25} {1,-20} {2,-30}" -f $user.Name, $enabled, $lastLogin)
        }
        
        Write-Host "`nTotal users: $($users.Count)" -ForegroundColor Green
        
    } catch {
        Write-Host "Error retrieving user information: $_" -ForegroundColor Red
    }
}
