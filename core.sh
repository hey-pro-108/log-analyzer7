#!/usr/bin/env bash

REPORT_DIR="$HOME/.log-analyzer/reports"
mkdir -p "$REPORT_DIR"

analyze_ssh() {
    echo ""
    echo "SSH Log Analysis"
    echo ""
    
    if [ -f "/var/log/auth.log" ]; then
        echo "Failed Login Attempts (last 20):"
        echo ""
        grep "Failed password" /var/log/auth.log | tail -20 | while read line; do
            echo "  $line"
        done
        
        echo ""
        echo "Failed Login by IP:"
        echo ""
        grep "Failed password" /var/log/auth.log | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | head -10 | while read count ip; do
            echo "  $count attempts from $ip"
        done
    else
        echo "[!] SSH log not found: /var/log/auth.log"
    fi
    
    echo ""
    echo -n "Press Enter to continue..."
    read
}

analyze_web() {
    echo ""
    echo "Web Server Log Analysis"
    echo ""
    
    WEB_LOG=""
    if [ -f "/var/log/apache2/access.log" ]; then
        WEB_LOG="/var/log/apache2/access.log"
    elif [ -f "/var/log/nginx/access.log" ]; then
        WEB_LOG="/var/log/nginx/access.log"
    fi
    
    if [ -n "$WEB_LOG" ]; then
        echo "Top 10 Requested URLs:"
        echo ""
        awk '{print $7}' "$WEB_LOG" | sort | uniq -c | sort -nr | head -10 | while read count url; do
            echo "  $count requests to $url"
        done
        
        echo ""
        echo "Top 10 IPs by Requests:"
        echo ""
        awk '{print $1}' "$WEB_LOG" | sort | uniq -c | sort -nr | head -10 | while read count ip; do
            echo "  $count requests from $ip"
        done
        
        echo ""
        echo "SQL Injection Attempts:"
        echo ""
        grep -E "(union|select|insert|drop|' OR '1'='1)" "$WEB_LOG" | tail -10 | while read line; do
            echo "  $line"
        done
    else
        echo "[!] Web server log not found"
    fi
    
    echo ""
    echo -n "Press Enter to continue..."
    read
}

detect_bruteforce() {
    echo ""
    echo "Brute Force Detection"
    echo ""
    
    if [ -f "/var/log/auth.log" ]; then
        echo "IPs with multiple failed logins (>10 attempts):"
        echo ""
        grep "Failed password" /var/log/auth.log | awk '{print $(NF-3)}' | sort | uniq -c | awk '$1 > 10' | sort -nr | while read count ip; do
            echo "  [!] $ip - $count failed attempts"
        done
    fi
    
    WEB_LOG=""
    if [ -f "/var/log/apache2/access.log" ]; then
        WEB_LOG="/var/log/apache2/access.log"
    elif [ -f "/var/log/nginx/access.log" ]; then
        WEB_LOG="/var/log/nginx/access.log"
    fi
    
    if [ -n "$WEB_LOG" ]; then
        echo ""
        echo "IPs with multiple 404 errors (>50 attempts):"
        echo ""
        grep " 404 " "$WEB_LOG" | awk '{print $1}' | sort | uniq -c | awk '$1 > 50' | sort -nr | while read count ip; do
            echo "  [!] $ip - $count 404 errors"
        done
    fi
    
    echo ""
    echo -n "Press Enter to continue..."
    read
}

detect_suspicious_ips() {
    echo ""
    echo "Suspicious IP Detection"
    echo ""
    
    SUSPICIOUS_FILE="$REPORT_DIR/suspicious_ips.txt"
    > "$SUSPICIOUS_FILE"
    
    if [ -f "/var/log/auth.log" ]; then
        grep "Failed password" /var/log/auth.log | awk '{print $(NF-3)}' | sort | uniq -c | awk '$1 > 5' | awk '{print $2}' >> "$SUSPICIOUS_FILE"
    fi
    
    WEB_LOG=""
    if [ -f "/var/log/apache2/access.log" ]; then
        WEB_LOG="/var/log/apache2/access.log"
    elif [ -f "/var/log/nginx/access.log" ]; then
        WEB_LOG="/var/log/nginx/access.log"
    fi
    
    if [ -n "$WEB_LOG" ]; then
        grep " 404 " "$WEB_LOG" | awk '{print $1}' | sort | uniq -c | awk '$1 > 20' | awk '{print $2}' >> "$SUSPICIOUS_FILE"
    fi
    
    if [ -s "$SUSPICIOUS_FILE" ]; then
        echo "Suspicious IPs detected:"
        echo ""
        sort -u "$SUSPICIOUS_FILE" | while read ip; do
            echo "  [!] $ip"
        done
    else
        echo "No suspicious IPs detected"
    fi
    
    echo ""
    echo -n "Press Enter to continue..."
    read
}
