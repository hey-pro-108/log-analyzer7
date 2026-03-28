#!/usr/bin/env bash

generate_full_report() {
    local report_file="$REPORT_DIR/log_report_$(date +%Y%m%d_%H%M%S).txt"
    
    echo ""
    echo "Generating report..."
    echo ""
    
    {
        echo "Log Analyzer - Security Report"
        echo "Generated: $(date)"
        echo "============================================================"
        echo ""
        
        echo "SSH Failed Logins Summary"
        echo "------------------------------------------------------------"
        if [ -f "/var/log/auth.log" ]; then
            grep "Failed password" /var/log/auth.log | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | head -10 | while read count ip; do
                echo "$count attempts from $ip"
            done
        else
            echo "No SSH logs found"
        fi
        
        echo ""
        echo "Web Server Summary"
        echo "------------------------------------------------------------"
        WEB_LOG=""
        if [ -f "/var/log/apache2/access.log" ]; then
            WEB_LOG="/var/log/apache2/access.log"
        elif [ -f "/var/log/nginx/access.log" ]; then
            WEB_LOG="/var/log/nginx/access.log"
        fi
        
        if [ -n "$WEB_LOG" ]; then
            echo "Total requests: $(wc -l < "$WEB_LOG")"
            echo "Total 404 errors: $(grep -c " 404 " "$WEB_LOG")"
            echo "SQL injection attempts: $(grep -cE "(union|select|insert|drop)" "$WEB_LOG")"
        else
            echo "No web logs found"
        fi
        
        echo ""
        echo "Suspicious IPs Detected"
        echo "------------------------------------------------------------"
        SUSPICIOUS_FILE="$REPORT_DIR/suspicious_ips.txt"
        if [ -f "$SUSPICIOUS_FILE" ] && [ -s "$SUSPICIOUS_FILE" ]; then
            sort -u "$SUSPICIOUS_FILE" | while read ip; do
                echo "$ip"
            done
        else
            echo "No suspicious IPs"
        fi
        
        echo ""
        echo "============================================================"
        echo "Report saved: $report_file"
        
    } > "$report_file"
    
    echo "[INFO] Report saved: $report_file"
    echo ""
    
    cat "$report_file"
    
    echo ""
    echo -n "Press Enter to continue..."
    read
}
