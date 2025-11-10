#!/bin/bash

backup_directory_to_usb() {
    echo ""
    echo -e "${GREEN}=== BACKUP DIRECTORY TO USB ===${NC}"
    echo ""

    # Get source directory
    read -p "Enter the source directory path to backup: " source_dir

    # Validate source directory
    if [ ! -d "$source_dir" ]; then
        echo -e "${RED}Error: Source directory does not exist.${NC}"
        return
    fi

    # Display available mount points
    echo ""
    echo -e "${YELLOW}Available mount points:${NC}"
    df -h | grep -v "tmpfs" | grep -v "devtmpfs" | tail -n +2 | awk '{printf "  %s - %s free\n", $6, $4}'

    echo ""
    read -p "Enter the destination USB drive path (e.g., /media/usb/backup): " dest_drive

    # Create destination directory if it doesn't exist
    if [ ! -d "$dest_drive" ]; then
        echo -e "${YELLOW}Destination directory does not exist. Creating it...${NC}"
        mkdir -p "$dest_drive" 2>/dev/null

        if [ $? -ne 0 ]; then
            echo -e "${RED}Error: Cannot create destination directory. Check permissions.${NC}"
            return
        fi

        echo -e "${GREEN}Created destination directory: $dest_drive${NC}"
    fi

    # Perform backup
    echo ""
    echo -e "${YELLOW}Starting backup...${NC}"
    echo -e "${WHITE}Source: $source_dir${NC}"
    echo -e "${WHITE}Destination: $dest_drive${NC}"
    echo ""

    # Count total files
    total_files=$(find "$source_dir" -type f 2>/dev/null | wc -l)
    echo -e "${YELLOW}Found $total_files files to backup...${NC}"
    echo ""

    # Copy files with rsync (if available) or cp
    if command -v rsync &> /dev/null; then
        rsync -av --progress "$source_dir/" "$dest_drive/"
        backup_status=$?
    else
        cp -rv "$source_dir/"* "$dest_drive/"
        backup_status=$?
    fi

    if [ $backup_status -eq 0 ]; then
        echo ""
        echo -e "${GREEN}Backup completed successfully!${NC}"

        # Create catalog file
        catalog_path="$dest_drive/backup_catalog.txt"
        echo ""
        echo -e "${YELLOW}Creating backup catalog...${NC}"

        {
            echo "============================================"
            echo "BACKUP CATALOG"
            echo "============================================"
            echo "Backup Date: $(date '+%Y-%m-%d %H:%M:%S')"
            echo "Source Directory: $source_dir"
            echo "Total Files Backed Up: $total_files"
            echo "============================================"
            echo ""
            printf "%-30s %-60s %-25s %s\n" "File Name" "File Path" "Last Modified" "Size (Bytes)"
            printf "%-30s %-60s %-25s %s\n" "---------" "---------" "-------------" "-----------"

            # List all files with details
            find "$source_dir" -type f 2>/dev/null | while read -r filepath; do
                    relative_path="${filepath#$source_dir/}"
                    file_name=$(basename "$filepath")
                    last_modified=$(stat -c "%y" "$filepath" 2>/dev/null | cut -d'.' -f1)
                    file_size=$(stat -c "%s" "$filepath" 2>/dev/null)
                    printf "%-30s %-60s %-25s %s\n" "$file_name" "$relative_path" "$last_modified" "$file_size"
            done
        } > "$catalog_path"

        echo -e "${GREEN}Catalog created: $catalog_path${NC}"
        echo ""
        echo -e "${CYAN}Backup Summary:${NC}"
        echo -e "  ${WHITE}Files copied: $total_files${NC}"
        echo -e "  ${WHITE}Catalog file: $catalog_path${NC}"
    else
        echo ""
        echo -e "${RED}Error: Backup failed.${NC}"
    fi
}
