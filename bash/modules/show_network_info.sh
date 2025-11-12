#!/bin/bash

show_network_info() {
    echo ""
    echo -e "${GREEN}=== NETWORK INFORMATION ===${NC}"
    echo ""

    # Get active network interfaces
    interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -v "lo")

    if [ -z "$interfaces" ]; then
        echo -e "${RED}No active network interfaces found (excluding loopback).${NC}"
        return
    fi

    echo -e "${CYAN}Network Interfaces:${NC}"
    for iface in $interfaces; do
        echo -e "----------------------------------"
        echo -e "${YELLOW}Interface: $iface${NC}"

        # Get IPv4 Address
        ipv4=$(ip addr show "$iface" | grep -oP 'inet \K[\d.]+')
        [ -z "$ipv4" ] && ipv4="Not configured"
        echo -e "  ${WHITE}IPv4 Address: $ipv4${NC}"

        # Get IPv6 Address
        ipv6=$(ip addr show "$iface" | grep -oP 'inet6 \K[\w:]+')
        [ -z "$ipv6" ] && ipv6="Not configured"
        echo -e "  ${WHITE}IPv6 Address: $ipv6${NC}"

        # Get MAC Address
        mac=$(ip link show "$iface" | grep -oP 'link/ether \K[\w:]+')
        [ -z "$mac" ] && mac="N/A"
        echo -e "  ${WHITE}MAC Address:  $mac${NC}"
    done
    echo -e "----------------------------------"
    echo ""

    # Get Default Gateway
    gateway=$(ip route | grep default | awk '{print $3}')
    echo -e "${CYAN}Default Gateway:${NC}"
    if [ -z "$gateway" ]; then
        echo -e "  ${YELLOW}No default gateway found.${NC}"
    else
        echo -e "  ${WHITE}$gateway${NC}"
    fi
    echo ""

    # Get DNS Servers
    echo -e "${CYAN}DNS Servers:${NC}"
    dns_servers=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}')
    if [ -z "$dns_servers" ]; then
        echo -e "  ${YELLOW}No DNS servers found in /etc/resolv.conf.${NC}"
    else
        while read -r server; do
            echo -e "  ${WHITE}$server${NC}"
        done <<< "$dns_servers"
    fi

    echo ""
}
