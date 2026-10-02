#!/usr/bin/env bash
# GPU summary, exits cleanly if no NVIDIA GPU/driver present
if ! command -v nvidia-smi >/dev/null 2>&1; then
  echo "nvidia-smi not found (no driver or no GPU)."; lspci | grep -i nvidia || echo "No NVIDIA PCI device."; exit 0
fi
nvidia-smi --query-gpu=index,name,driver_version,temperature.gpu,power.draw,utilization.gpu,memory.used,memory.total --format=csv
echo "--- Xid errors:"; sudo dmesg | grep -i xid || echo none
