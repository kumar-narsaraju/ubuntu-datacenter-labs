#!/usr/bin/env bash
# Simple server health report for Ubuntu 22.04
echo "== $(hostname) $(date) =="
echo "-- Uptime/Load"; uptime
echo "-- Memory"; free -h
echo "-- Disk (warn >85%)"
df -hP -x tmpfs -x devtmpfs | awk 'NR>1 {gsub("%","",$5); if ($5+0>85) print "WARN",$0; else print "OK  ",$0}'
echo "-- Failed services"; systemctl --failed --no-legend || true
echo "-- Network"; ip -br a
echo "-- RAID"; [ -r /proc/mdstat ] && cat /proc/mdstat
echo "-- GPU"; command -v nvidia-smi >/dev/null && nvidia-smi --query-gpu=name,temperature.gpu,utilization.gpu --format=csv || echo "no nvidia-smi"
