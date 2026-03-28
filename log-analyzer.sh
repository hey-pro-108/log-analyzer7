#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$SCRIPT_DIR"

source ./core.sh
source ./report.sh

echo "Log Analyzer demo"
echo "Developed by: Hexa Dev"
echo ""

show_menu() {
    echo ""
    echo "[1] Analyze SSH Logs (Failed Logins)"
    echo "[2] Analyze Web Server Logs"
    echo "[3] Detect Brute Force Attacks"
    echo "[4] Detect Suspicious IPs"
    echo "[5] Generate Full Report"
    echo "[6] Exit"
    echo ""
    echo -n "Select: "
    read -r choice
    
    case $choice in
        1) analyze_ssh ;;
        2) analyze_web ;;
        3) detect_bruteforce ;;
        4) detect_suspicious_ips ;;
        5) generate_full_report ;;
        6) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option"; sleep 1 ;;
    esac
}

while true; do
    show_menu
done
