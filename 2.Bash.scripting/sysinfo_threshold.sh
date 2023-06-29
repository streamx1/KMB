#!/bin/bash

# You should input there threshold for CPU,RAM and disk_free in %, but threshold for disk_io in IOPS (how m>

cpu_threshold=90
ram_threshold=80
disk_io_threshold=1000
disk_free_threshold=10

# functions for check threshold

check_threshold1()
{
    local value=$1
    local threshold=$2
    local parameter=$3

    if (( value > threshold ));
        then
        echo "!!! WARNING: $parameter exceeded the threshold ($value > $threshold) !!!" >&2
    fi
}


check_threshold2()
{
    local value=$1
    local threshold=$2
    local parameter=$3

    if (( value < threshold ));
        then
        echo "!!! WARNING: $parameter exceeded the threshold ($value > $threshold) !!!" >&2
    fi
}

echo " === CPU usage, %  ==="
cpu_usage0=$(mpstat | awk '/all/ {print 100 - $NF}')
cpu_usage=$(mpstat | awk '/all/ {printf "%.0f", 100 - $NF}')
echo $cpu_usage0
check_threshold1 "$cpu_usage" "$cpu_threshold" "CPU"

echo " === RAM usage, %  ==="
ram_usage0=$(free | awk '/Mem:/ {printf "%.2f", ($3/$2) * 100}')
ram_usage=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2) * 100}')
echo $ram_usage0
check_threshold1 "$ram_usage" "$ram_threshold" "RAM"

echo " === Disk IO, IOPS ==="
disk_io_usage0=$(iostat -d | awk '/^[a-z]/ {sum += $2} END {print sum}')
disk_io_usage=$(iostat -d | awk '/^[a-z]/ {sum += $2} END {printf "%.0f", sum}')
echo $disk_io_usage0
check_threshold1 "$disk_io_usage" "$disk_io_threshold" "Disk IO"

echo " === Disk Free, % ==="
disk_free_usage=$(df -h | awk '/\/$/ {print $5}' | tr -d '%')
echo $((100-$disk_free_usage))
check_threshold2 "$disk_free_usage" "$disk_free_threshold" "Disk Free"

