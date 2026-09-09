# Linux Diagnostic Toolkit

A Bash-based Linux diagnostic toolkit for performing basic system, disk, and network checks.

## Project Structure

```text
assignment-1/
├── README.md
├── disk-check.sh
├── grade.sh
├── network-check.sh
├── system-info.sh
└── logs/
    └── .gitkeep
```

## Requirements

- Linux environment
- Bash
- Standard Linux command-line utilities

## Setup

Make the Bash scripts executable:

```bash
chmod +x *.sh
```

## Usage

### System Information

Run:

```bash
./system-info.sh
```

The script displays:

- Hostname
- Current user
- Date and time
- Operating system
- Kernel version
- System uptime
- CPU information
- Memory information
- Current working directory

### Disk Check

Run:

```bash
./disk-check.sh <threshold>
```

Example:

```bash
./disk-check.sh 80
```

The default path is `/`.

A specific path can also be supplied:

```bash
./disk-check.sh 80 /tmp
```

The threshold must be an integer between 1 and 100.

The script:

- Displays disk usage percentage.
- Exits with status `0` when usage is below the threshold.
- Exits with a non-zero status when usage reaches or exceeds the threshold.
- Exits with status `2` when invalid input is provided.

### Network Check

Run:

```bash
./network-check.sh <hostname-or-ip>
```

Example:

```bash
./network-check.sh google.com
```

A TCP port can also be supplied:

```bash
./network-check.sh google.com 443
```

The script:

- Validates the host.
- Resolves and displays the host address.
- Performs a basic connectivity check.
- Displays network interface information.
- Checks TCP connectivity when a port is supplied.
- Validates ports from 1 to 65535.

## Logging

Diagnostic operations are recorded in:

```text
logs/diagnostic.log
```

Log entries include a timestamp and a description of the operation performed.

## Testing

### Check Bash Syntax

```bash
bash -n system-info.sh
bash -n disk-check.sh
bash -n network-check.sh
```

### Test System Information

```bash
./system-info.sh
```

### Test Disk Check

```bash
./disk-check.sh 90
./disk-check.sh 90 /tmp
```

### Test Invalid Disk Input

```bash
./disk-check.sh
./disk-check.sh abc
./disk-check.sh 0
./disk-check.sh 101
./disk-check.sh 90 /does-not-exist
```

### Test Network Check

```bash
./network-check.sh google.com
./network-check.sh google.com 443
```

### Test Invalid Network Input

```bash
./network-check.sh
./network-check.sh google.com abc
./network-check.sh google.com 0
./network-check.sh google.com 65536
```

### View Logs

```bash
cat logs/diagnostic.log
```

## Assumptions

- The scripts are designed to run in a Linux environment.
- Bash and the required standard Linux utilities are available.
- Network connectivity may be required for successful hostname resolution and connectivity tests.
- Network results may vary depending on the target host and network conditions.
