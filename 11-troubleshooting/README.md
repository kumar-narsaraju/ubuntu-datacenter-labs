# 11 - Troubleshooting Scenarios

Treat each like a ticket. Break it (or have a friend break it), then diagnose with logs and commands. Write down root cause and fix.

| # | Ticket | Tools |
|---|--------|-------|
| 1 | Server unreachable by SSH after netplan change | VM console, `netplan try`, `ip a`, `ip route` |
| 2 | `/` is 100% full | `df -h`, `du`, `lsof +L1`, `journalctl --vacuum-size` |
| 3 | Boots to emergency mode after editing fstab | recovery, UUIDs, `nofail` |
| 4 | RAID shows `[U_]` | `mdadm --detail`, replace disk, rebuild |
| 5 | High load, system slow | `top`, `vmstat`, `iostat`, `pidstat`, `iotop` |
| 6 | Service will not start | `systemctl status`, `journalctl -xeu <svc>` |
| 7 | DNS fails but ping by IP works | `resolvectl`, `/etc/resolv.conf`, `dig` |
| 8 | NFS mount hangs | `showmount`, `rpcinfo`, firewall, `mount -v` |
| 9 | `nvidia-smi` fails | `dmesg`, `lsmod`, `dkms status`, Secure Boot, nouveau |
| 10 | GPU throttling / Xid error | `nvidia-smi -q -d PERFORMANCE,TEMPERATURE`, dmesg, BMC sensors |
| 11 | Slurm node is `down` / `drain` | `scontrol show node`, `slurmd -C`, munge, time sync |
| 12 | Packet loss between two nodes | `mtr`, `ethtool -S`, `ip -s link`, MTU mismatch |

## Method
1. What changed? 2. Reproduce 3. Check logs 4. Isolate (network, storage, CPU, software) 5. Fix 6. Document
