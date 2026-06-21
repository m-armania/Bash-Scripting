#!/bin/bash
while getopts ":v" opt; do
case $opt in
        v) VERBOSE=true;;
        \?) echo "Usage $0 [v]" >&2; exit 1;;
        esac
done
echo "HOSTNAME: $(hostname)"
echo "UPTIME: $(uptime -p)"
echo "LOGGED-IN USERS:"
w
echo "TOP 5 CPU PROCESSES:"
if [ "$VERBOSE" = "true" ]; then
        ps aux --sort=-%cpu | head -6 
else
        ps aux --sort=-%cpu | awk 'NR<=6 {printf "%-8s %-6s %-6s %s\n", $2, $3, $4, $6}'
fi
echo "DISK USAGE:" 
df -h



