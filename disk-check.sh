##########################################################
# Disk-check.sh
# execute with ./disk-check.sh <threshold> [path] (e.g;./disk-check.sh 80 /home means  Check /home and warn me if it reaches 80%.) when path is not provided check /(root directory)

# Tasks 
#• Default path: /.
#• Threshold must be an integer from 1 to 100.
#• Display the disk usage percentage.
#• Exit 0 when usage is below the threshold.
#• Exit non-zero when usage reaches or exceeds the threshold.
#• Exit 2 for invalid input


##############################################################


#/bin/bash

# Validate the threshold
if [[ -z "$1" ]]; then
    echo "Error: threshold is required."
    exit 2
fi



# Validate that it is a number
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: threshold must be an integer."
    exit 2
fi



# validate that the range
if (( $1 < 1 || $1 > 100 )); then
    echo "Error: threshold must be between 1 and 100."
    exit 2
fi



# Set the default path
threshold="$1"
path="${2:-/}" # Use $2 if it exists; otherwise use /



# Check whether the path exists
if [[ ! -d "$path" ]]; then
    echo "Error: path does not exist or is not a directory."
    exit 2
fi

# Get disk usage
usage=$(df -P "$path" | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk usage: ${usage}%"
echo "Threshold: ${threshold}%"
echo "Path: $path"

# Log output in logs/diagnoatics.log
echo "$(date '+%Y-%m-%d %H:%M:%S') - Disk check performed on $path; usage=${usage}%; threshold=${threshold}%" >> logs/diagnostic.log

#Set exit code
if (( usage < threshold )); then
    echo "Disk usage is below the threshold."
    exit 0
else
    echo "Warning: disk usage has reached or exceeded the threshold."
    exit 1
fi


# exit code(0=success, 1= issue-detected, 2=invalid-input)check with echo $?command.
