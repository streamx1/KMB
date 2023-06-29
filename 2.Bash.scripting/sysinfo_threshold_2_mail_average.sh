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

# File to store previous values
previous_values_file="~/values_store.txt"

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

# Functions for checking thresholds

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

# Function for sending email

send_email() {
    local message=$1
    echo "$message" | mail -s "$subject" "$recipient"
}

# Function to calculate average of previous values1
calculate_average1() {
    local parameter=$1
    local current_value=$2

    # Read previous value from file
    if [[ -f "$previous_values_file" ]]; then
        local previous_value=$(grep "$parameter" "$previous_values_file" | cut -d "=" -f 2)
    fi

    # Write current value to file
    echo "$parameter=$current_value" > "$previous_values_file"

    # Calculate average
    if [[ -n "$previous_value" ]]; then
        local average=$(awk "BEGIN { printf \"%.2f\", ($previous_value + $current_value) / 2 }")
        echo "Previous $parameter: $previous_value"
        echo "Current $parameter : $current_value"
        echo "Average $parameter : $average"
        check_threshold1 "$average" "$cpu_threshold" "CPU"
    fi
}

# Function to calculate average of previous values2
calculate_average2() {
    local parameter=$1
    local current_value=$2

    # Read previous value from file
    if [[ -f "$previous_values_file" ]]; then
        local previous_value=$(grep "$parameter" "$previous_values_file" | cut -d "=" -f 2)
    fi

    # Write current value to file
    echo "$parameter=$current_value" > "$previous_values_file"

    # Calculate average
    if [[ -n "$previous_value" ]]; then
        local average=$(awk "BEGIN { printf \"%.2f\", ($previous_value + $current_value) / 2 }")
        echo "Previous $parameter: $previous_value"
        echo "Current $parameter : $current_value"
        echo "Average $parameter : $average"
        check_threshold2 "$average" "$cpu_threshold" "CPU"
    fi
}

echo " === CPU usage, %  ==="

cpu_usage0=$(mpstat | awk '/all/ {print 100 - $NF}')
cpu_usage=$(mpstat | awk '/all/ {printf "%.0f", 100 - $NF}')

echo "$cpu_usage0"

calculate_average1 "CPU" "$cpu_usage"

echo " === RAM usage, %  ==="

ram_usage0=$(free | awk '/Mem:/ {printf "%.2f", ($3/$2) * 100}')
ram_usage=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2) * 100}')

echo "$ram_usage0"

calculate_average1 "RAM" "$ram_usage"

echo " === Disk IO, IOPS ==="

disk_io_usage0=$(iostat -d | awk '/^[a-z]/ {sum += $2} END {print sum}')
disk_io_usage=$(iostat -d | awk '/^[a-z]/ {sum += $2} END {printf "%.0f", sum}')

echo "$disk_io_usage0"

calculate_average1 "Disk IO" "$disk_io_usage"

echo " === Disk Free, % ==="

disk_free_usage=$(df -h | awk '/\/$/ {print $5}' | tr -d '%')

echo $((100-$disk_free_usage))

calculate_average2 "Disk free" "$disk_free_usage" 
