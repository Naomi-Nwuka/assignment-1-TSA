#!/bin/bash

echo "===== SYSTEM INFORMATION ====="

echo "Hostname is $(hostname)"
echo "Current User is $(whoami)"
echo "Date/Time: $(date)"
echo "Operating System: $(grep '^PRETTY_NAME=' /etc/os-release | cut -d '"' -f 2)"
echo "Kernel Version: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "CPU Information:"
lscpu
echo "Memory Information:"
free -h
echo "Current Working Directory is $(pwd)"
