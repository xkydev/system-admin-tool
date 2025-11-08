#!/bin/bash

show_menu() {
    clear
    echo -e "${CYAN}============================================${NC}"
    echo -e "${CYAN}   SYSTEM ADMINISTRATION TOOL (Linux)${NC}"
    echo -e "${CYAN}============================================${NC}"
    echo ""
    echo -e "${YELLOW}1. Display System Users${NC}"
    echo -e "${YELLOW}2. Display Filesystem/Disk Information${NC}"
    echo -e "${YELLOW}3. Find Largest Files${NC}"
    echo -e "${YELLOW}4. Memory and Swap Usage${NC}"
    echo -e "${YELLOW}5. Backup Directory to USB${NC}"
    echo -e "${RED}6. Exit${NC}"
    echo ""
    echo -e "${CYAN}============================================${NC}"
}
