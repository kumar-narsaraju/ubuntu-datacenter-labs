# 02 - Networking (Netplan, VLAN, Bond, Bridge, Firewall)

Ubuntu 22.04 uses **Netplan** (`/etc/netplan/*.yaml`) with systemd-networkd or NetworkManager.

## Lab 2.1 Inspect
```bash
ip -br a ; ip route ; ip link
resolvectl status
ss -tulpn
ethtool enp0s3        # speed, duplex, link
```

## Lab 2.2 Static IP with Netplan
```bash
sudo cp /etc/netplan/*.yaml /root/netplan.bak
sudo nano /etc/netplan/00-lab.yaml
```
```yaml
network:
  version: 2
  ethernets:
    enp0s8:
      addresses: [192.168.56.10/24]
```
```bash
sudo chmod 600 /etc/netplan/*.yaml
sudo netplan try        # auto-rollback if you lose connection
sudo netplan apply
```

## Lab 2.3 DNS and gateway
```yaml
    enp0s3:
      dhcp4: false
      addresses: [10.0.2.15/24]
      routes:
        - to: default
          via: 10.0.2.2
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]
```
Test: `ping -c3 8.8.8.8`, `dig ubuntu.com`, `resolvectl query ubuntu.com`.

## Lab 2.4 VLAN
```yaml
  vlans:
    vlan10:
      id: 10
      link: enp0s8
      addresses: [10.10.10.5/24]
```
Verify: `ip -d link show vlan10`

## Lab 2.5 Bonding (NIC redundancy)
Needs two NICs (add a third adapter to the VM).
```yaml
  bonds:
    bond0:
      interfaces: [enp0s8, enp0s9]
      addresses: [10.0.0.10/24]
      parameters:
        mode: active-backup
        mii-monitor-interval: 100
```
Verify: `cat /proc/net/bonding/bond0`. Then `sudo ip link set enp0s8 down` and watch failover.
Modes to study: active-backup, balance-xor, 802.3ad (LACP, needs switch support).

## Lab 2.6 Bridge (used by VMs and containers)
```yaml
  bridges:
    br0:
      interfaces: [enp0s8]
      addresses: [192.168.56.20/24]
```
`bridge link` , `ip a show br0`

## Lab 2.7 Firewall
```bash
sudo ufw default deny incoming
sudo ufw allow 22/tcp
sudo ufw allow from 192.168.56.0/24 to any port 5201
sudo ufw enable ; sudo ufw status verbose
sudo nft list ruleset | head -50
```

## Lab 2.8 Performance and packet capture
```bash
sudo apt install -y iperf3 tcpdump mtr traceroute nmap
# server VM:  iperf3 -s
# client VM:  iperf3 -c 192.168.56.10 -P 4
sudo tcpdump -i enp0s8 -nn icmp
mtr -rw 8.8.8.8
```
Study: MTU (`ip link set dev enp0s8 mtu 9000` = jumbo frames), RDMA/InfiniBand and RoCE (concepts, used in GPU clusters).

## Break and fix
Apply a bad gateway in netplan; use `netplan try` to recover; then do it with `apply` and recover from the VM console.
