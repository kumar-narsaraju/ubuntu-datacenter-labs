# 01 - Linux Fundamentals

## Lab 1.1 Users, groups, permissions
```bash
sudo adduser opsuser
sudo usermod -aG sudo opsuser
id opsuser
mkdir /tmp/share && chmod 750 /tmp/share
sudo chown root:opsuser /tmp/share
ls -ld /tmp/share
```
Exercise: create group `dcteam`, a shared dir where files created by members stay group-owned (`chmod g+s`).

## Lab 1.2 Packages (apt)
```bash
apt search htop
sudo apt install -y htop tree curl wget vim net-tools
apt list --installed | wc -l
apt policy openssh-server
sudo apt-mark hold openssh-server && sudo apt-mark unhold openssh-server
```

## Lab 1.3 systemd services
```bash
systemctl status ssh
sudo systemctl stop ssh && sudo systemctl start ssh
systemctl list-units --failed
systemctl list-unit-files --state=enabled
```
Exercise: write your own service `/etc/systemd/system/hello.service` that runs a script, enable it, reboot, verify.

## Lab 1.4 Logs
```bash
journalctl -b                 # this boot
journalctl -u ssh --since "1 hour ago"
journalctl -p err -b          # errors only
dmesg -T | tail -50
less /var/log/auth.log
```

## Lab 1.5 Processes and resources
```bash
top ; htop
ps aux --sort=-%mem | head
free -h ; df -h ; uptime
vmstat 1 5 ; iostat -xz 1 3   # sudo apt install sysstat
```
Exercise: run `stress-ng --cpu 2 --timeout 60s` and watch with htop.

## Lab 1.6 Hardware inventory
```bash
lscpu ; lsmem ; lspci ; lsusb ; lsblk
sudo dmidecode -t system -t memory | less
sudo lshw -short
```

## Break and fix
Fill `/` with `fallocate -l` until 100%, find what ate it with `du -xh / | sort -h | tail`, and clean up.
