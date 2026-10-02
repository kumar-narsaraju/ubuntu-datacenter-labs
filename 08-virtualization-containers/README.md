# 08 - Virtualization and Containers

## Lab 8.1 KVM / libvirt
Needs nested virtualization enabled on your VM host.
```bash
egrep -c '(vmx|svm)' /proc/cpuinfo
sudo apt install -y qemu-kvm libvirt-daemon-system virtinst bridge-utils
sudo usermod -aG libvirt,kvm $USER
virsh list --all
virsh net-list --all
```
Create a VM with `virt-install`, attach it to your `br0` bridge, snapshot with `virsh snapshot-create-as`.

## Lab 8.2 Docker
```bash
sudo apt install -y docker.io
sudo usermod -aG docker $USER
docker run --rm hello-world
docker run -d -p 8080:80 --name web nginx
docker ps ; docker logs web ; docker stats --no-stream
docker volume create data
docker network ls
```
Exercise: run nginx with a bind mount on your LVM volume.

## Concepts
VM vs container, hypervisors (KVM, VMware ESXi, Hyper-V), LXD, Kubernetes basics, OpenStack overview.
