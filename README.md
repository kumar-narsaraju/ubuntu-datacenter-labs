# Ubuntu Server 22.04 Data Center Labs

Hands-on practice labs for learning **Ubuntu Server 22.04 LTS** administration the way it is used in data centers: networking, storage, monitoring, security, virtualization, **GPU and compute servers**, and HPC clusters. Start small, finish with a full capstone.

> Every lab is practical: you type the commands, break things on purpose, and fix them. Use a VM, never a production server.

## Learning path

| # | Module | You will learn |
|---|--------|----------------|
| 00 | [Lab setup](00-lab-setup/) | VM/Multipass setup, snapshots, safe practice habits |
| 01 | [Linux fundamentals](01-linux-fundamentals/) | Users, permissions, packages, systemd, logs, processes |
| 02 | [Networking](02-networking/) | Netplan, static IP, DNS, VLAN, bonding, bridges, firewall, tcpdump, iperf3 |
| 03 | [Storage](03-storage/) | Disks, partitions, filesystems, fstab, LVM, RAID (mdadm), NFS, iSCSI, SMART, quotas |
| 04 | [BMC / IPMI](04-bmc-ipmi/) | Out-of-band management (see your ipmi-bmc-toolkit repo) |
| 05 | [Monitoring and logging](05-monitoring-logging/) | journald, rsyslog, node_exporter, Prometheus, alerts |
| 06 | [Automation](06-automation/) | Bash, cron, systemd timers, cloud-init, Ansible |
| 07 | [Security](07-security/) | SSH hardening, UFW, fail2ban, auditd, updates |
| 08 | [Virtualization and containers](08-virtualization-containers/) | KVM/libvirt, Docker |
| 09 | [GPU and compute](09-gpu-compute/) | NVIDIA drivers, nvidia-smi, CUDA, DCGM, NUMA, benchmarks, container GPU |
| 10 | [HPC cluster](10-hpc-cluster/) | Shared storage, Slurm, MPI, NCCL |
| 11 | [Troubleshooting](11-troubleshooting/) | Break/fix scenarios like real tickets |
| 12 | [Capstone](12-capstone/) | Build a mini data-center node end to end |

## What you need

- A PC with 16 GB RAM (8 GB minimum), 60 GB free disk
- VirtualBox, VMware Workstation Player, or Multipass
- Ubuntu Server 22.04 LTS ISO: https://releases.ubuntu.com/22.04/
- Modules 00-08, 10 (single node), 11, 12 work fully in VMs. Module 09 GPU parts need a real NVIDIA GPU (or a cloud GPU instance); the rest of that module (NUMA, hardware inventory, benchmarks) works anywhere.

## How to use each lab

1. Read the **Goal**
2. Take a VM snapshot
3. Run the commands, read the output, understand every flag
4. Do the **Exercises**
5. Do the **Break and fix** challenge
6. Write your own notes in `notes/` (optional)

## Related

- IPMI/BMC toolkit: https://github.com/kumar-narsaraju/ipmi-bmc-toolkit

## License

GPL-3.0 or MIT, your choice when you create the repo.
