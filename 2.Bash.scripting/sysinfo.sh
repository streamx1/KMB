#!/bin/bash


echo "1. === CPU ==="
mpstat

echo "2. === RAM ==="
free -h

echo "3. === Disk IO ==="
iostat

echo "4. === Disk Free ==="
df -h


