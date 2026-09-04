#############################################################################
# System-info.sh

# Display hostname, current user, date/time, operating system, kernel version,
# uptime, CPU information, memory information, and current working director

##############################################################################


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


echo "$(date '+%Y-%m-%d %H:%M:%S') - System information check performed" >> logs/diagnostic.log
