function Show-NetworkInfo {
    <#
    .SYNOPSIS
        Displays detailed network information for all active adapters.
    
    .DESCRIPTION
        Retrieves and displays network configuration for each connected
        network adapter, including IP addresses, MAC, gateway, and DNS servers.
    
    .EXAMPLE
        Show-NetworkInfo
    #>
    
    Write-Host "`n=== NETWORK INFORMATION ===" -ForegroundColor Green
    Write-Host ""
    
    try {
        # Get all connected network adapters
        $adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }
        
        if ($adapters.Count -eq 0) {
            Write-Host "No active network adapters found." -ForegroundColor Yellow
            return
        }
        
        Write-Host "Network Interfaces:" -ForegroundColor Cyan
        
        foreach ($adapter in $adapters) {
            Write-Host "----------------------------------"
            Write-Host "Interface: $($adapter.Name)" -ForegroundColor Yellow
            Write-Host "  Description:   $($adapter.InterfaceDescription)" -ForegroundColor White
            Write-Host "  MAC Address:   $($adapter.MacAddress)" -ForegroundColor White
            
            # Get IP configuration for the current adapter
            $ipConfig = Get-NetIPConfiguration -InterfaceIndex $adapter.InterfaceIndex
            
            # Display IPv4 and IPv6 addresses
            if ($ipConfig.IPv4Address.IPAddress) {
                Write-Host "  IPv4 Address:  $($ipConfig.IPv4Address.IPAddress)" -ForegroundColor White
            } else {
                Write-Host "  IPv4 Address:  Not configured" -ForegroundColor White
            }
            
            if ($ipConfig.IPv6Address.IPAddress) {
                Write-Host "  IPv6 Address:  $($ipConfig.IPv6Address.IPAddress)" -ForegroundColor White
            } else {
                Write-Host "  IPv6 Address:  Not configured" -ForegroundColor White
            }
            
            # Display Gateway
            if ($ipConfig.IPv4DefaultGateway.NextHop) {
                Write-Host "  Gateway:       $($ipConfig.IPv4DefaultGateway.NextHop)" -ForegroundColor White
            } else {
                Write-Host "  Gateway:       Not configured" -ForegroundColor White
            }
            
            # Display DNS Servers
            if ($ipConfig.DNSServer.ServerAddresses) {
                $dnsServers = $ipConfig.DNSServer.ServerAddresses -join ", "
                Write-Host "  DNS Servers:   $dnsServers" -ForegroundColor White
            } else {
                Write-Host "  DNS Servers:   Not configured" -ForegroundColor White
            }
        }
        Write-Host "----------------------------------"
        
    } catch {
        Write-Host "Error retrieving network information: $_" -ForegroundColor Red
    }
}
