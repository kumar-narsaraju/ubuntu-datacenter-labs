# 06 - Automation

## Lab 6.1 Bash health script
Use `scripts/health-check.sh`:
```bash
chmod +x scripts/health-check.sh
./scripts/health-check.sh
```
Exercise: add disk SMART status and failed-services checks.

## Lab 6.2 Scheduling
```bash
crontab -e      # */5 * * * * /home/ubuntu/scripts/health-check.sh >> /var/log/health.log
systemctl list-timers
```
Write a systemd timer (`.service` + `.timer`) that runs the script daily.

## Lab 6.3 cloud-init
Create a `user-data` file:
```yaml
#cloud-config
hostname: node01
users:
  - name: ops
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys: [ssh-ed25519 AAAA... you@pc]
packages: [htop, iperf3, fio]
```
Test with Multipass: `multipass launch 22.04 --cloud-init user-data`.

## Lab 6.4 Ansible
```bash
sudo apt install -y ansible
cat > inventory.ini <<'X'
[servers]
192.168.56.10
192.168.56.11
X
ansible -i inventory.ini servers -m ping
ansible-playbook -i inventory.ini playbook.yml
```
Playbook idea: install packages, push a netplan file, configure UFW, create users.

## Concepts
Infrastructure as Code, MAAS (bare-metal provisioning used with Ubuntu), PXE boot, Kickstart/autoinstall, idempotency.
