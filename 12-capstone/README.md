# 12 - Capstone: Build a Mini Data Center Node

Build from a fresh Ubuntu 22.04 VM. Document each step in your own README.

1. Hostname, static IP (Netplan), DNS, NTP (chrony)
2. Bond or bridge on two NICs
3. Storage: LVM on RAID 1 for `/data`, separate `/var/log`, NFS export
4. Hardened SSH, UFW rules, fail2ban, unattended upgrades
5. node_exporter + Prometheus + Grafana dashboard + disk alert
6. Health-check script via systemd timer
7. Docker with a sample service on `/data`
8. Slurm single node, submit three jobs
9. (GPU machine) driver, CUDA container test, DCGM diag, GPU dashboard
10. Write a runbook: how to rebuild, how to recover each failure from Module 11

Bonus: automate the whole thing with Ansible or cloud-init.
