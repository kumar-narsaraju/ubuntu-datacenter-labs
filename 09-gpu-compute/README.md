# 09 - GPU and Compute Servers

Parts A and B work on any machine. Part C-E need an NVIDIA GPU (physical server, workstation, or cloud GPU instance).

## Part A: Compute hardware inventory
```bash
lscpu
lscpu | grep -E 'Model name|Socket|Core|Thread|NUMA'
numactl --hardware             # sudo apt install numactl
lstopo-no-graphics             # sudo apt install hwloc
sudo dmidecode -t memory | grep -E 'Size|Speed|Locator'
cat /sys/kernel/mm/transparent_hugepage/enabled
cpupower frequency-info        # sudo apt install linux-tools-generic
```
Concepts: sockets, cores, threads, NUMA, memory channels, PCIe lanes/generations, hugepages, CPU governors.

## Part B: Benchmark CPU, memory, disk
```bash
sudo apt install -y stress-ng sysbench fio
sysbench cpu --threads=$(nproc) run
sysbench memory run
stress-ng --cpu $(nproc) --vm 2 --vm-bytes 1G --timeout 60s --metrics-brief
numactl --cpunodebind=0 --membind=0 sysbench memory run
```

## Part C: NVIDIA driver on Ubuntu 22.04
```bash
lspci | grep -i nvidia
sudo apt install -y ubuntu-drivers-common
ubuntu-drivers devices
sudo ubuntu-drivers install            # or: sudo apt install nvidia-driver-535-server
sudo reboot
nvidia-smi
```
Notes:
- Datacenter GPUs (A100/H100/L40) normally use the `-server` driver branch.
- If Secure Boot is on, the module must be signed (MOK enrollment) or you get "NVIDIA-SMI has failed".
- Check `lsmod | grep nouveau`; the open-source nouveau driver must not be loaded.

## Part D: nvidia-smi for operations
```bash
nvidia-smi -L
nvidia-smi -q | less
nvidia-smi --query-gpu=name,temperature.gpu,power.draw,utilization.gpu,memory.used,memory.total --format=csv -l 2
nvidia-smi dmon
nvidia-smi topo -m             # NVLink / PCIe topology
sudo nvidia-smi -pm 1          # persistence mode
sudo nvidia-smi -pl 250        # power limit (watts, card dependent)
nvidia-smi --query-compute-apps=pid,name,used_memory --format=csv
```
Concepts: ECC errors, Xid errors (`sudo dmesg | grep -i xid`), thermal throttling, NVLink, MIG (A100/H100 partitioning: `nvidia-smi mig -lgip`).

## Part E: CUDA, containers, DCGM
CUDA toolkit: install from NVIDIA's apt repo for Ubuntu 22.04 (developer.nvidia.com/cuda-downloads), then `nvcc --version`.

GPU in Docker:
```bash
# install nvidia-container-toolkit (NVIDIA docs), then:
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
docker run --rm --gpus all nvidia/cuda:12.2.0-base-ubuntu22.04 nvidia-smi
```
DCGM (datacenter GPU health):
```bash
sudo apt install -y datacenter-gpu-manager
sudo systemctl enable --now nvidia-dcgm
dcgmi discovery -l
dcgmi diag -r 1          # quick; -r 3 is a long stress test
```
Monitoring: DCGM exporter to Prometheus, then Grafana GPU dashboard.

## Part F: Quick GPU stress test (with GPU)
```bash
git clone https://github.com/wilicc/gpu-burn && cd gpu-burn && make && ./gpu_burn 60
```
Watch temperature and clocks in another terminal with `nvidia-smi dmon`.

## No GPU? Do this instead
Read the sample outputs, practice parsing them in `scripts/gpu-report.sh` (it exits cleanly without a GPU), and use a cheap cloud GPU instance for an hour for Parts C-F.

## Break and fix
Install a driver that does not match your kernel or leave nouveau loaded, diagnose with `dmesg`, `journalctl -k`, `dkms status`, fix it.
