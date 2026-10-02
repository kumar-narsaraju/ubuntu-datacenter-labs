# 00 - Lab Setup

## Goal
A safe Ubuntu 22.04 VM you can break and restore.

## Steps
1. Install VirtualBox (or VMware Player).
2. Create VM: 2 vCPU, 4 GB RAM, 20 GB disk. Add **2 network adapters** (NAT + Host-only) and **3 extra 2 GB disks** (for storage labs).
3. Install Ubuntu Server 22.04 (minimal, enable OpenSSH server).
4. First login, then:
```bash
sudo apt update && sudo apt -y upgrade
cat /etc/os-release
uname -r
ip -br a
lsblk
```
5. Take a snapshot named `clean-install`.

## Quick alternative: Multipass
```bash
multipass launch 22.04 --name lab1 --cpus 2 --memory 4G --disk 20G
multipass shell lab1
```

## Habits
- Snapshot before every lab
- Use `sudo`, never stay in a root shell
- Back up a config before editing: `sudo cp file file.bak`
- Read `man <command>` or `<command> --help` first
