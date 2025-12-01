#!/bin/bash

# Uninstaller for NetScan Pro

TOOL_DIR="$HOME/netscan"
CMD="$PREFIX/bin/netscan"

echo "[*] Uninstalling NetScan Pro..."

# Remove tool directory
if [ -d "$TOOL_DIR" ]; then
    rm -rf "$TOOL_DIR"
    echo "[✔] Removed directory: $TOOL_DIR"
else
    echo "[!] Tool directory not found. Skipping."
fi

# Remove command
if [ -f "$CMD" ]; then
    rm -f "$CMD"
    echo "[✔] Removed command: netscan"
else
    echo "[!] Command not found. Skipping."
fi

echo "[✔] NetScan Pro has been successfully uninstalled!"
