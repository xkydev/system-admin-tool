#!/bin/bash

show_system_users() {
    echo ""
    echo -e "${GREEN}=== SYSTEM USERS ===${NC}"
    echo ""
    
    # Display header
    printf "${CYAN}%-20s %-30s %-30s${NC}\n" "Username" "UID" "Last Login"
    printf "${CYAN}%-20s %-30s %-30s${NC}\n" "--------" "---" "----------"
    
    # Read /etc/passwd to get all users
    while IFS=: read -r username password uid gid gecos home shell; do
        # Only show users with UID >= 1000 (regular users) or system users with login shells
        if [ "$uid" -ge 1000 ] || [ "$uid" -eq 0 ]; then
            # Get last login information
            last_login=$(lastlog -u "$username" 2>/dev/null | tail -n 1 | awk '{
                if (NF < 4 || $2 == "**Never") {
                    print "Never logged in"
                } else {
                    for(i=4; i<=NF; i++) printf "%s ", $i
                    print ""
                }
            }')
            
            # Clean up the last login string
            last_login=$(echo "$last_login" | xargs)
            [ -z "$last_login" ] && last_login="Never logged in"
            
            printf "%-20s %-30s %-30s\n" "$username" "$uid" "$last_login"
        fi
    done < /etc/passwd
    
    echo ""
    total_users=$(awk -F: '{if ($3 >= 1000 || $3 == 0) print $1}' /etc/passwd | wc -l)
    echo -e "${GREEN}Total users listed: $total_users${NC}"
}
