### Usefull utilities
#### Run utils: hd, free, ps, top


```bash

1. All about HDD

streamx@ubuntu111:~$ lsblk
NAME                      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0                       7:0    0  63.3M  1 loop /snap/core20/1822
loop1                       7:1    0  63.5M  1 loop /snap/core20/1891
loop2                       7:2    0 111.9M  1 loop /snap/lxd/24322
loop3                       7:3    0  53.2M  1 loop /snap/snapd/19122
loop4                       7:4    0  49.8M  1 loop /snap/snapd/18357
sda                         8:0    0    25G  0 disk
├─sda1                      8:1    0     1M  0 part
├─sda2                      8:2    0     2G  0 part /boot
└─sda3                      8:3    0    23G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0  11.5G  0 lvm  /
sr0                        11:0    1  1024M  0 rom

streamx@ubuntu111:~$ sudo hdparm -I /dev/sda3
[sudo] password for streamx:

/dev/sda3:

ATA device, with non-removable media
        Model Number:       VBOX HARDDISK
        Serial Number:      VB57fa0c9d-465916a3
        Firmware Revision:  1.0
Standards:
        Used: ATA/ATAPI-6 published, ANSI INCITS 361-2002
        Supported: 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:    16514064
        LBA    user addressable sectors:    52428800
        LBA48  user addressable sectors:    52428800
        Logical/Physical Sector size:           512 bytes
        device size with M = 1024*1024:       25600 MBytes
        device size with M = 1000*1000:       26843 MBytes (26 GB)
        cache/buffer size  = 256 KBytes (type=DualPortCache)
Capabilities:
        LBA, IORDY(cannot be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Vendor, no device specific minimum
        R/W multiple sector transfer: Max = 128 Current = 128
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns

streamx@ubuntu111:~$ df -h
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                              1.3G  1.1M  1.3G   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   12G  4.0G  6.7G  38% /
tmpfs                              6.4G     0  6.4G   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
/dev/sda2                          2.0G  130M  1.7G   8% /boot
tmpfs                              1.3G  4.0K  1.3G   1% /run/user/1000


2. free

streamx@ubuntu111:~$ free -h
               total        used        free      shared  buff/cache   available
Mem:            12Gi       224Mi        12Gi       1.0Mi       298Mi        12Gi
Swap:             0B          0B          0B

3. ps

streamx@ubuntu111:~$ ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0 166372 11704 ?        Ss   08:47   0:01 /sbin/init
root           2  0.0  0.0      0     0 ?        S    08:47   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<   08:47   0:00 [rcu_gp]
...
streamx      942  0.0  0.0  17084  9696 ?        Ss   08:48   0:00 /lib/systemd/systemd --user
streamx      943  0.0  0.0 169288  3804 ?        S    08:48   0:00 (sd-pam)
streamx     1043  0.0  0.0  17212  8308 ?        S    08:48   0:00 sshd: streamx@pts/0
streamx     1044  0.0  0.0   8732  5608 pts/0    Ss   08:48   0:00 -bash
root        1138  0.0  0.0      0     0 ?        I    08:53   0:00 [kworker/1:0-cgroup_destroy]
root        1140  0.0  0.0      0     0 ?        I    08:53   0:00 [kworker/u4:3-events_power_efficient]
root        1152  0.0  0.0      0     0 ?        I    09:02   0:00 [kworker/0:1]
root        1160  0.0  0.0      0     0 ?        I    09:09   0:00 [kworker/u4:0-events_power_efficient]
root        1161  0.0  0.0      0     0 ?        I    09:15   0:00 [kworker/u4:1-events_unbound]
streamx     1162  0.0  0.0  10068  1564 pts/0    R+   09:16   0:00 ps aux

4. top

streamx@ubuntu111:~$ top
top - 06:18:19 up 30 min,  1 user,  load average: 0.00, 0.00, 0.00
Tasks: 111 total,   1 running, 110 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.3 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :  12978.0 total,  12400.7 free,    228.7 used,    348.6 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.  12495.5 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
      1 root      20   0  166372  11704   8384 S   0.0   0.1   0:01.26 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd
      3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp
```

### Using VI, nano
#### Monitoring script: develop a script that gets and outputs CPU, RAM and disk IO/free

```bash
streamx@ubuntu111:~$ nano sysinfo.sh

#!/bin/bash

echo "1. === CPU ==="
mpstat

echo "2. === RAM ==="
free -h

echo "3. === Disk IO ==="
iostat

echo "4. === Disk Free ==="
df -h

streamx@ubuntu111:~$ chmod +x sysinfo.sh

streamx@ubuntu111:~$ ~/sysinfo.sh

1. === CPU ===
Linux 5.15.0-72-generic (ubuntu111)     05/24/2023      _x86_64_        (2 CPU)

10:22:36 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
10:22:36 AM  all    0.14    0.02    0.10    0.04    0.00    0.02    0.00    0.00    0.00   99.68

2. === RAM ===
               total        used        free      shared  buff/cache   available
Mem:            12Gi       245Mi        11Gi       1.0Mi       461Mi        12Gi
Swap:             0B          0B          0B
3. === Disk IO ===
Linux 5.15.0-72-generic (ubuntu111)     05/24/2023      _x86_64_        (2 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.26    0.03    0.23    0.08    0.00   99.40

Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd
dm-0              6.00       119.35        45.38         0.00     342917     130384          0
loop0             0.01         0.12         0.00         0.00        346          0          0
loop1             0.07         0.75         0.00         0.00       2146          0          0
loop2             0.02         0.39         0.00         0.00       1115          0          0
loop3             0.37        12.44         0.00         0.00      35743          0          0
loop4             0.01         0.12         0.00         0.00        345          0          0
loop5             0.00         0.00         0.00         0.00         14          0          0
sda               4.26       122.95        45.44         0.00     353255     130568          0
sr0               0.00         0.00         0.00         0.00          1          0          0


4. === Disk Free ===
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                              1.3G  1.2M  1.3G   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   12G  4.0G  6.7G  38% /
tmpfs                              6.4G     0  6.4G   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
/dev/sda2                          2.0G  130M  1.7G   8% /boot
tmpfs                              1.3G  4.0K  1.3G   1% /run/user/1000

```

### Streams. Conditions. 
#### Same as previous, but checks if certain system parameters exceed a threshold and Conditions outputs an alarm to the error stream.

```bash


streamx@ubuntu111:~$ nano sysinfo_threshold.sh

#!/bin/bash

# You should input there threshold for CPU,RAM and disk_free in %, 
# but threshold for disk_io in IOPS (how much operation I/O per second)


cpu_threshold=90
ram_threshold=80
disk_io_threshold=1000
disk_free_threshold=10

# functions for checking threshold

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



streamx@ubuntu111:~$ chmod +x sysinfo_threshold.sh

----------OUTPUT 1:

streamx@ubuntu111:~$ sudo ~/sysinfo_threshold.sh
 === CPU usage, %  ===
0.23
 === RAM usage, %  ===
1.87
 === Disk IO, IOPS ===
3.88
 === Disk Free, % ===
62

----------OUTPUT 2 ( with changed threshold to min):

streamx@ubuntu111:~$ sudo ~/sysinfo_threshold.sh
 === CPU usage, %  ===
0.23
 === RAM usage, %  ===
1.87
!!! WARNING: RAM exceeded the threshold (2 > 1) !!!
 === Disk IO, IOPS ===
3.88
!!! WARNING: Disk IO exceeded the threshold (4 > 1) !!!
 === Disk Free, % ===
62
!!! WARNING: Disk Free exceeded the threshold (38 > 99) !!!

```

### Arguments.
#### Same as previous, but compares parameters with threshold passed as arguments, as named arguments.

```bash

streamx@ubuntu111:~$ nano sysinfo_threshold_2.sh

#!/bin/bash

# You should input the threshold values as named arguments:
# sysinfo_threshold.sh --cpu_t 90 --ram_t 80 --disk-io_t 1000 --disk_free_t 10

# Default values

cpu_threshold=90
ram_threshold=80
disk_io_threshold=1000
disk_free_threshold=10

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
    fi
}

check_threshold2() {
    local value=$1
    local threshold=$2
    local parameter=$3

    if (( value < threshold )); then
        echo "!!! WARNING: $parameter exceeded the threshold ($value < $threshold) !!!" >&2
    fi
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

echo " === Disk Free, % ==="

disk_free_usage=$(df -h | awk '/\/$/ {print $5}' | tr -d '%')

echo $((100-$disk_free_usage))

check_threshold2 "$disk_free_usage" "$disk_free_threshold" "Disk Free"



streamx@ubuntu111:~$ chmod +x sysinfo_threshold_2.sh

----------OUTPUT 1:

streamx@ubuntu111:~$ ~/sysinfo_threshold_2.sh --cpu_t 90 --ram_t 90 --disk_io_t 1000 --disk_free_t 10

 === CPU usage, %  ===
0.87
 === RAM usage, %  ===
1.66
 === Disk IO, IOPS ===
8.17
 === Disk Free, % ===
62


----------OUTPUT 2 ( with changed threshold to min):

streamx@ubuntu111:~$ ~/sysinfo_threshold_2.sh --cpu_t 1 --ram_t 1 --disk_io_t 1 --disk_free_t 99

 === CPU usage, %  ===
0.82
 === RAM usage, %  ===
1.66
!!! WARNING: RAM exceeded the threshold (2 > 1) !!!
 === Disk IO, IOPS ===
7.4
!!! WARNING: Disk IO exceeded the threshold (7 > 1) !!!
 === Disk Free, % ===
62
!!! WARNING: Disk Free exceeded the threshold (38 < 99) !!!

```

### Crontab.
#### Same as previous, but does the check every 5 minutes.

```bash

streamx@ubuntu111:~$ crontab -e
no crontab for streamx - using an empty one

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.basic
  3. /usr/bin/vim.tiny
  4. /bin/ed

Choose 1-4 [1]: 1
crontab: installing new crontab

---
*/5 * * * * ~/sysinfo_threshold_2.sh
---

```


### Smtp implementation.
#### Same as previous, but sends an alerting e-mail.

``` bash

sudo apt-get install mailutils
sudo apt-get install ssmtp

streamx@ubuntu111:~$ sudo nano /etc/ssmtp/ssmtp.conf

root=sales@aplink.by
mailhub=mailbeХХ.hoster.by:465
AuthUser=sales@aplink.by
AuthPass=ХХХХХ
UseTLS=YES

streamx@ubuntu111:~$ sudo nano ~/sysinfo_threshold_2_mail.sh
streamx@ubuntu111:~$ sudo chmod +x ~/sysinfo_threshold_2_mail.sh

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

echo " === Disk Free, % ==="

disk_free_usage=$(df -h | awk '/\/$/ {print $5}' | tr -d '%')

echo $((100-$disk_free_usage))
check_threshold2 "$disk_free_usage" "$disk_free_threshold" "Disk Free"

```

### Variables.
#### Same as above, but stores previous values and do the analysis against mean values.

```bash


streamx@ubuntu111:~$ sudo nano ~/sysinfo_threshold_2_mail_average.sh
streamx@ubuntu111:~$ sudo chmod +x ~/sysinfo_threshold_2_mail_average.sh

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

```




