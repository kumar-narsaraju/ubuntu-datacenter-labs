# Cheatsheet (Ubuntu 22.04)

| Task | Command |
|------|---------|
| IP/routes | `ip -br a`, `ip route` |
| Apply network | `sudo netplan try` / `apply` |
| Listening ports | `ss -tulpn` |
| Disks | `lsblk -f`, `blkid`, `df -hT` |
| LVM | `pvs vgs lvs`, `lvextend -r` |
| RAID | `cat /proc/mdstat`, `mdadm --detail /dev/md0` |
| Service logs | `journalctl -xeu <svc>` |
| Failed units | `systemctl --failed` |
| CPU/NUMA | `lscpu`, `numactl --hardware` |
| GPU | `nvidia-smi`, `nvidia-smi topo -m`, `dcgmi diag -r 1` |
| BMC | `ipmitool sensor`, `ipmitool sel list` |
| Slurm | `sinfo`, `squeue`, `scontrol show node` |
