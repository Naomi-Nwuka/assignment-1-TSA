#/bin/bash

if [[ -z "$1" ]]; then
    echo "Error: threshold is required."
    exit 2
fi

if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: threshold must be an integer."
    exit 2
fi

if (( $1 < 1 || $1 > 100 )); then
    echo "Error: threshold must be between 1 and 100."
    exit 2
fi

threshold="$1"
path="${2:-/}"

if [[ ! -d "$path" ]]; then
    echo "Error: path does not exist or is not a directory."
    exit 2
fi

usage=$(df -P "$path" | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk usage: ${usage}%"
echo "Threshold: ${threshold}%"
echo "Path: $path"

if (( usage < threshold )); then
    echo "Disk usage is below the threshold."
    exit 0
else
    echo "Warning: disk usage has reached or exceeded the threshold."
    exit 1
fi
