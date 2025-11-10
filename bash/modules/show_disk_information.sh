#!/bin/bash

show_disk_information() {
    echo ""
    echo -e "${GREEN}=== DISK INFORMATION ===${NC}"
    echo ""

    # Display header
    printf "${CYAN}%-30s %-20s %-20s %-10s${NC}\n" "Filesystem/Mount Point" "Total Size (Bytes)" "Free Space (Bytes)" "% Used"
    printf "${CYAN}%-30s %-20s %-20s %-10s${NC}\n" "----------------------" "------------------" "-------------------" "------"

    # Get filesystem information using df
    df -T | grep -v "tmpfs" | grep -v "devtmpfs" | tail -n +2 | while read -r filesystem fstype blocks used available percent mount; do
        # Convert 1K blocks to bytes
        total_bytes=$((blocks * 1024))
        free_bytes=$((available * 1024))

        printf "%-30s %-20s %-20s %-10s\n" "$mount" "$total_bytes" "$free_bytes" "$percent"
    done

    echo ""
    echo -e "${YELLOW}Note: Sizes are shown in bytes${NC}"
}
