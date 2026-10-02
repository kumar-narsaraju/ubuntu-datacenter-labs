# 03 - Storage (Disks, LVM, RAID, NFS, iSCSI)

Use the extra VM disks (`sdb`, `sdc`, `sdd`). **Double-check device names with `lsblk` before every command.**
No spare disks? Make fake ones:
```bash
for i in 1 2 3; do truncate -s 1G /var/tmp/disk$i.img; sudo losetup -fP /var/tmp/disk$i.img; done
losetup -a
```

## Lab 3.1 Partition, filesystem, mount
```bash
lsblk -f
sudo parted /dev/sdb --script mklabel gpt mkpart primary ext4 1MiB 100%
sudo mkfs.ext4 /dev/sdb1
sudo mkdir /mnt/data && sudo mount /dev/sdb1 /mnt/data
df -hT /mnt/data
```
Persistent mount, use UUID:
```bash
sudo blkid /dev/sdb1
echo 'UUID=<uuid> /mnt/data ext4 defaults,nofail 0 2' | sudo tee -a /etc/fstab
sudo mount -a   # test BEFORE rebooting
```
Compare `ext4` vs `xfs` (`sudo apt install xfsprogs`, `mkfs.xfs`).

## Lab 3.2 LVM
```bash
sudo apt install -y lvm2
sudo pvcreate /dev/sdb /dev/sdc
sudo vgcreate vg_data /dev/sdb /dev/sdc
sudo lvcreate -L 1G -n lv_app vg_data
sudo mkfs.ext4 /dev/vg_data/lv_app
sudo mount /dev/vg_data/lv_app /mnt/app
# grow online
sudo lvextend -L +500M -r /dev/vg_data/lv_app
sudo pvs ; sudo vgs ; sudo lvs
```
Exercise: snapshot `lvcreate -s -L 200M -n snap1 /dev/vg_data/lv_app`, change files, restore.

## Lab 3.3 Software RAID (mdadm)
```bash
sudo apt install -y mdadm
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc
cat /proc/mdstat ; sudo mdadm --detail /dev/md0
sudo mkfs.ext4 /dev/md0 && sudo mount /dev/md0 /mnt/raid
# simulate a disk failure
sudo mdadm /dev/md0 --fail /dev/sdb
sudo mdadm /dev/md0 --remove /dev/sdb
sudo mdadm /dev/md0 --add /dev/sdd
watch cat /proc/mdstat
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
sudo update-initramfs -u
```
Study RAID 0, 1, 5, 6, 10: capacity, speed, fault tolerance. Try RAID 5 with three disks.

## Lab 3.4 Disk health and performance
```bash
sudo apt install -y smartmontools fio
sudo smartctl -a /dev/sda
sudo fio --name=seqwrite --filename=/mnt/data/testfile --rw=write --bs=1M --size=512M --direct=1
sudo fio --name=randread --filename=/mnt/data/testfile --rw=randread --bs=4k --size=512M --iodepth=16 --runtime=30 --time_based
iostat -xz 1
```
Understand: IOPS vs throughput vs latency, HDD vs SSD vs NVMe (`nvme list`, `nvme smart-log /dev/nvme0`).

## Lab 3.5 Quotas
```bash
sudo apt install -y quota
# add usrquota to the fstab options, remount
sudo quotacheck -cum /mnt/data && sudo quotaon /mnt/data
sudo setquota -u opsuser 100M 120M 0 0 /mnt/data
```

## Lab 3.6 NFS (shared storage)
Server:
```bash
sudo apt install -y nfs-kernel-server
echo '/srv/share 192.168.56.0/24(rw,sync,no_subtree_check)' | sudo tee -a /etc/exports
sudo mkdir -p /srv/share && sudo exportfs -ra && sudo exportfs -v
```
Client:
```bash
sudo apt install -y nfs-common
showmount -e 192.168.56.10
sudo mount -t nfs 192.168.56.10:/srv/share /mnt/nfs
```

## Lab 3.7 iSCSI (SAN concept)
Target:
```bash
sudo apt install -y targetcli-fb
sudo targetcli    # create backstore (fileio), iqn target, LUN, ACL
```
Initiator:
```bash
sudo apt install -y open-iscsi
sudo iscsiadm -m discovery -t sendtargets -p 192.168.56.10
sudo iscsiadm -m node --login
lsblk
```
Study: multipath (`multipath-tools`), FC vs iSCSI, SAN vs NAS vs DAS, Ceph overview.

## Break and fix
Wrong UUID in fstab without `nofail`, reboot into emergency mode, recover. Then fail a RAID disk and rebuild.
