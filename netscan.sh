#!/bin/bash

# -----------------------------------------
#  NetScan Pro - Modern CLI Network Tool
# -----------------------------------------

VERSION="3.0"
AUTHOR="ShellCrafter"
UPDATE_URL="https://raw.githubusercontent.com/nullrepo/netscan/main/netscan.sh" # change if needed

# Colors
R="\033[1;31m"
G="\033[1;32m"
Y="\033[1;33m"
B="\033[1;34m"
C="\033[1;36m"
W="\033[1;37m"
N="\033[0m"

# Fade-in animation function (only used once)
fade() {
    text="$1"
    delay=${2:-0.02}

    while IFS='' read -r line; do
        str=""
        len=${#line}
        for ((i=0; i<len; i++)); do
            str="${str}${line:$i:1}"
            printf "${C}%s${N}\r" "$str"
            sleep "$delay"
        done
        echo ""
    done <<< "$text"
}

# Animated header (first time only)
header() {
clear
fade "
╔══════════════════════════════════════════════╗
║                NetScan Pro v$VERSION               ║
║               by $AUTHOR                        ║
╚══════════════════════════════════════════════╝
"
}

# NON-animated header (for menu refresh)
normal_header() {
clear
echo -e "
${C}╔══════════════════════════════════════════════╗
║                NetScan Pro v$VERSION               ║
║               by $AUTHOR                        ║
╚══════════════════════════════════════════════╝${N}
"
}

# Auto-update
update_tool() {
    echo -e "${Y}Checking for updates...${N}"
    tmpfile=$(mktemp)

    if curl -s -L "$UPDATE_URL" -o "$tmpfile"; then
        mv "$tmpfile" "$0"
        chmod +x "$0"
        echo -e "${G}Updated successfully! Restart the tool.${N}"
    else
        echo -e "${R}Update failed.${N}"
    fi
}

# Tool Functions
ping_test() { read -p "Enter host: " host; ping -c 4 "$host"; }
trace_test() { read -p "Enter host: " host; traceroute "$host"; }
whois_test() { read -p "Enter domain: " domain; whois "$domain"; }
dns_lookup() { read -p "Enter domain: " domain; nslookup "$domain"; }
port_scan() { read -p "Enter host/IP: " host; nmap "$host"; }
lan_scan() { ip -4 neigh; }
public_ip() { curl -s ifconfig.me; echo ""; }
geoip_lookup() { read -p "Enter IP: " ip; curl -s "https://ipapi.co/$ip/json"; echo ""; }
header_scan() { read -p "Enter URL (with https://): " url; curl -I "$url"; }
subdomain_scan() { read -p "Enter domain: " domain; curl -s "https://api.hackertarget.com/hostsearch/?q=$domain"; echo ""; }

# Menu
menu() {
echo -e "
${B}╔══════════════════════════════════════╗
║              MAIN MENU               ║
╚══════════════════════════════════════╝${N}

${G}1${N}) Ping
${G}2${N}) Traceroute
${G}3${N}) Whois Lookup
${G}4${N}) DNS Lookup (nslookup)
${G}5${N}) Port Scan (nmap)
${G}6${N}) LAN Device Scan
${G}7${N}) Check Public IP
${G}8${N}) GeoIP Lookup
${G}9${N}) HTTP Header Scanner
${G}10${N}) Subdomain Finder
${G}11${N}) Auto Update Tool
${G}12${N}) Exit
"
}

# --------------------
#  Main Execution Loop
# --------------------

header   # show animation ONCE

while true; do
    normal_header   # no animation on return
    menu

    read -p "Select an option: " ch
    echo ""

    case $ch in
        1) ping_test ;;
        2) trace_test ;;
        3) whois_test ;;
        4) dns_lookup ;;
        5) port_scan ;;
        6) lan_scan ;;
        7) public_ip ;;
        8) geoip_lookup ;;
        9) header_scan ;;
        10) subdomain_scan ;;
        11) update_tool ;;
        12) exit ;;
        *) echo -e "${R}Invalid option.${N}" ;;
    esac

    echo -e "\nPress Enter to continue..."
    read
done
