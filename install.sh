#!/data/data/com.termux/files/usr/bin/bash

GREEN="\033[1;32m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${CYAN}"
echo "====================================="
echo "      Installing NetScanner Pro      "
echo "====================================="
echo -e "${RESET}"

echo -e "${YELLOW}[+] Updating packages...${RESET}"
pkg update -y && pkg upgrade -y

echo -e "${YELLOW}[+] Installing dependencies...${RESET}"
pkg install -y python
pkg install -y nmap
pkg install -y dnsutils
pkg install -y whois
pkg install -y iproute2
pkg install -y iputils
pkg install -y curl
pkg install -y wget
pkg install -y git
pkg install -y net-tools

pip install requests

chmod +x netscan.sh
cp netscan.sh $PREFIX/bin/netscan

echo -e "${GREEN}[✔] Installation Complete!"
echo -e "Run tool: ${CYAN}netscan${RESET}"
