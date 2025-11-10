#!/bin/bash

find_largest_files() {
    echo ""
    echo -e "${GREEN}=== FIND LARGEST FILES ===${NC}"
    echo ""

    # Display available filesystems
    echo -e "${YELLOW}Available filesystems:${NC}"
    df -h | grep -v "tmpfs" | grep -v "devtmpfs" | tail -n +2 | awk '{print "  " $6 " (" $2 " total)"}'

    echo ""
    read -p "Enter the path to search (e.g., / or /home): " search_path

    # Validate path
    if [ ! -d "$search_path" ]; then
        echo -e "${RED}Error: Invalid path specified.${NC}"
        return
    fi

    echo ""
    echo -e "${YELLOW}Searching for largest files in '$search_path'...${NC}"
    echo -e "${YELLOW}This may take a few moments...${NC}"
    echo ""

    # Display header
    printf "${CYAN}%-10s %-20s %-30s %s${NC}\n" "Rank" "Size (Bytes)" "File Name" "Full Path"
    printf "${CYAN}%-10s %-20s %-30s %s${NC}\n" "----" "-----------" "---------" "---------"

    # Find largest files (suppress permission denied errors)
    rank=1
    find "$search_path" -type f -exec du -b {} + 2>/dev/null | \
        sort -rn | \
        head -n 10 | \
        while read -r size filepath; do
            filename=$(basename "$filepath")
            printf "%-10s %-20s %-30s %s\n" "#$rank" "$size" "$filename" "$filepath"
            ((rank++))
        done

    echo ""
}
