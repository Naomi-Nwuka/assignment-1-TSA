###########################################################################
#network-check.sh
# excecute with ./network-check.sh <hostname-or-ip> [port]

# TASKS
#• Validate the host argument.
#• Resolve the host and display the resolved address.
#• Perform a basic connectivity check.
#• Display network interface information.
#• If a port is supplied, check TCP connectivity.
#• Valid ports are 1–65535.
#• Invalid input must return a non-zero result and should not crash the script

###########################################################################

#!/bin/bash

# Validate a host was supplied

if [[ -z "$1" ]]; then
    echo "Error: hostname or IP address is required."
    exit 2
fi
host="$1"

# Validate the port was supplied

if [[ -n "$2" ]]; then
    port="$2"

    if ! [[ "$port" =~ ^[0-9]+$ ]]; then
        echo "Error: port must be numeric."
        exit 2
    fi

    if (( port < 1 || port > 65535 )); then
        echo "Error: port must be between 1 and 65535."
        exit 2
    fi
fi

# Resolve the hostname 
getent hosts "$host"

# Perform connectivity check 
ping -c 1 "$host"

if ping -c 1 -W 2 "$host" >/dev/null 2>&1; then
    echo "Connectivity: OK"
else
    echo "Connectivity: FAILED"
fi

# Display network interfaces
echo "Network Interfaces:"
ip -br addr

# TCP port check
timeout 3 bash -c "</dev/tcp/$host/$port"

if timeout 3 bash -c "</dev/tcp/$host/$port" 2>/dev/null; then
    echo "TCP Port $port: reachable"
else
    echo "TCP Port $port: not reachable"
fi





