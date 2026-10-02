# 07 - Security Hardening

## Lab 7.1 SSH
```bash
ssh-keygen -t ed25519
ssh-copy-id user@server
sudo nano /etc/ssh/sshd_config.d/hardening.conf
```
```
PermitRootLogin no
PasswordAuthentication no
MaxAuthTries 3
AllowUsers opsuser
```
```bash
sudo sshd -t && sudo systemctl reload ssh
```
Keep a second session open while testing.

## Lab 7.2 fail2ban and UFW
```bash
sudo apt install -y fail2ban
sudo systemctl enable --now fail2ban
sudo fail2ban-client status sshd
```

## Lab 7.3 Updates and audit
```bash
sudo apt install -y unattended-upgrades auditd
sudo dpkg-reconfigure -plow unattended-upgrades
sudo auditctl -w /etc/passwd -p wa -k passwd_changes
sudo ausearch -k passwd_changes
```

## Lab 7.4 Other
`sudo aa-status` (AppArmor), `sudo lynis audit system`, sudoers with `visudo`, file integrity (AIDE), disk encryption (LUKS: `cryptsetup luksFormat`).

## Concepts
Least privilege, CIS benchmarks, patch cycles, Ubuntu Pro/Livepatch, secrets handling.
