#!/bin/bash

# Color definitions for better UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/modules"

# Source all module files
if [ ! -d "$MODULES_DIR" ]; then
    echo -e "${RED}Error: Modules directory not found at $MODULES_DIR${NC}"
    echo -e "${YELLOW}Please ensure all module files are in the 'modules' subdirectory.${NC}"
    exit 1
fi

# Load all modules
for module in "$MODULES_DIR"/*.sh; do
    if [ -f "$module" ]; then
        source "$module"
    fi
done

# Verify all required functions are loaded
required_functions=("show_menu" "show_system_users" "show_disk_information" "find_largest_files" "show_memory_usage" "backup_directory_to_usb")
for func in "${required_functions[@]}"; do
    if ! declare -f "$func" > /dev/null; then
        echo -e "${RED}Error: Required function '$func' not found.${NC}"
        echo -e "${YELLOW}Please ensure all module files are present in the modules directory.${NC}"
        exit 1
    fi
done

# ============================================================================
# Main Program Loop
# ============================================================================
main() {
    while true; do
        show_menu
        read -p "Enter your choice (1-6): " choice

        case $choice in
            1)
                show_system_users
                echo ""
                read -p "Press Enter to continue..."
                ;;
            2)
                show_disk_information
                echo ""
                read -p "Press Enter to continue..."
                ;;
            3)
                find_largest_files
                echo ""
                read -p "Press Enter to continue..."
                ;;
            4)
                show_memory_usage
                echo ""
                read -p "Press Enter to continue..."
                ;;
            5)
                backup_directory_to_usb
                echo ""
                read -p "Press Enter to continue..."
                ;;
            6)
                echo ""
                echo -e "${GREEN}Exiting... Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo ""
                echo -e "${RED}Invalid choice. Please select 1-6.${NC}"
                sleep 2
                ;;
        esac
    done
}

# Run the main program
main
