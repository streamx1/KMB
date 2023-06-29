#!/bin/bash

# You should input the threshold values as named arguments:
# sysinfo_threshold.sh --cpu_t 90 --ram_t 80 --disk-io_t 1000 --disk_free_t 10

# Default values

cpu_threshold=90
ram_threshold=80
disk_io_threshold=1000
disk_free_threshold=10

# Email settings
recipient="6264534@gmail.com" 
subject="System Threshold Exceeded"

# Input named arguments

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --cpu_t) cpu_threshold="$2"; shift ;;
        --ram_t) ram_threshold="$2"; shift ;;
        --disk_io_t) disk_io_threshold="$2"; shift ;;
        --disk_free_t) disk_free_threshold="$2"; shift ;;
        *) echo "Unknown parameter passed: $1" >&2; exit 1 ;;
    esac
    shift
done

# functions for checking thresholds

check_threshold1() {
    local value=$1
    local threshold=$2
    local parameter=$3

    if (( value > threshold )); then
        echo "!!! WARNING: $parameter exceeded the threshold ($value > $threshold) !!!" >&2
        send_email "$parameter exceeded the threshold ($value > $threshold)"
    fi
}

check_threshold2() {
    local value=$1
    local threshold=$2
    local parameter=$3

    if (( value < threshold )); then
        echo "!!! WARNING: $parameter exceeded the threshold ($value < $threshold) !!!" >&2
        send_email "$parameter exceeded the threshold ($value < $threshold)"
    fi
}

# functions for  sending email

send_email() {
    local message=$1
    echo "$message" | mail -s "$subject" "$recipient"
}

echo " === CPU usage, %  ==="

cpu_usage0=$(mpstat | awk '/all/ {print 100 - $NF}')
cpu_usage=$(mpstat | awk '/all/ {printf "%.0f", 100 - $NF}')

echo "$cpu_usage0"

check_threshold1 "$cpu_usage" "$cpu_threshold" "CPU"

echo " === RAM usage, %  ==="

ram_usage0=$(free | awk '/Mem:/ {printf "%.2f", ($3/$2) * 100}')
ram_usage=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2) * 100}')

echo "$ram_usage0"

check_threshold1 "$ram_usage" "$ram_threshold" "RAM"

echo " === Disk IO, IOPS ==="

disk_io_usage0=$(iostat -d | awk '/^[a-z]/ {sum += $2} END {print sum}')
disk_io_usage=$(iostat -d | awk '/^[a-z]/ {sum += $2} END {printf "%.0f", sum}')

echo "$disk_io_usage0"

check_threshold1 "$disk_io_usage" "$disk_io_threshold" "Disk IO"
