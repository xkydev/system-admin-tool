#!/bin/bash

show_memory_usage() {
    echo ""
    echo -e "${GREEN}=== MEMORY AND SWAP USAGE ===${NC}"
    echo ""
    
    # Get memory information from /proc/meminfo
    mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    mem_free=$(grep MemFree /proc/meminfo | awk '{print $2}')
    mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
    
    # Convert KB to bytes
    mem_total_bytes=$((mem_total * 1024))
    mem_free_bytes=$((mem_free * 1024))
    mem_available_bytes=$((mem_available * 1024))
    mem_used_bytes=$((mem_total_bytes - mem_available_bytes))
    
    # Calculate percentages
    mem_used_percent=$(awk "BEGIN {printf \"%.2f\", ($mem_used_bytes / $mem_total_bytes) * 100}")
    mem_free_percent=$(awk "BEGIN {printf \"%.2f\", ($mem_available_bytes / $mem_total_bytes) * 100}")
    
    echo -e "${CYAN}PHYSICAL MEMORY:${NC}"
    echo -e "  Total Memory:       ${WHITE}$mem_total_bytes bytes${NC}"
    echo -e "  Used Memory:        ${WHITE}$mem_used_bytes bytes ($mem_used_percent%)${NC}"
    echo -e "  Free Memory:        ${GREEN}$mem_available_bytes bytes ($mem_free_percent%)${NC}"
    echo ""
    
    # Get swap information
    swap_total=$(grep SwapTotal /proc/meminfo | awk '{print $2}')
    swap_free=$(grep SwapFree /proc/meminfo | awk '{print $2}')
    
    # Convert KB to bytes
    swap_total_bytes=$((swap_total * 1024))
    swap_free_bytes=$((swap_free * 1024))
    swap_used_bytes=$((swap_total_bytes - swap_free_bytes))
    
    echo -e "${CYAN}SWAP SPACE:${NC}"
    
    if [ "$swap_total_bytes" -eq 0 ]; then
        echo -e "  ${YELLOW}No swap space configured.${NC}"
    else
        # Calculate percentages
        swap_used_percent=$(awk "BEGIN {printf \"%.2f\", ($swap_used_bytes / $swap_total_bytes) * 100}")
        swap_free_percent=$(awk "BEGIN {printf \"%.2f\", ($swap_free_bytes / $swap_total_bytes) * 100}")
        
        echo -e "  Total Swap:         ${WHITE}$swap_total_bytes bytes${NC}"
        echo -e "  Used Swap:          ${WHITE}$swap_used_bytes bytes ($swap_used_percent%)${NC}"
        echo -e "  Free Swap:          ${GREEN}$swap_free_bytes bytes ($swap_free_percent%)${NC}"
    fi
    
    echo ""
}
