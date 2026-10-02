# 10 - HPC / Compute Cluster

Use 2-3 VMs: `node1` (controller + compute), `node2`, `node3` on a host-only network. Set hostnames and `/etc/hosts` entries.

## Lab 10.1 Prerequisites
- Same users/UIDs on all nodes
- Time sync: `timedatectl`, `chronyc tracking` (`sudo apt install chrony`)
- Shared home via NFS (Lab 3.6)
- Passwordless SSH between nodes

## Lab 10.2 Slurm (single node first)
```bash
sudo apt install -y slurm-wlm munge
sudo systemctl enable --now munge
```
`/etc/slurm/slurm.conf` (replace node1 with your hostname):
```
ClusterName=lab
SlurmctldHost=node1
MpiDefault=none
ProctrackType=proctrack/linuxproc
ReturnToService=2
SlurmUser=slurm
SlurmdSpoolDir=/var/lib/slurm/slurmd
StateSaveLocation=/var/lib/slurm/slurmctld
SchedulerType=sched/backfill
SelectType=select/cons_tres
NodeName=node1 CPUs=2 State=UNKNOWN
PartitionName=debug Nodes=node1 Default=YES MaxTime=INFINITE State=UP
```
```bash
sudo systemctl enable --now slurmctld slurmd
sinfo ; squeue
srun hostname
sbatch --wrap="sleep 30; hostname"
scontrol show node node1
```
GPU nodes use `Gres=gpu:N` and `gres.conf` (`NodeName=gpu1 Name=gpu File=/dev/nvidia0`).
Next: add node2/node3, copy the same `slurm.conf` and the munge key (`/etc/munge/munge.key`).

## Lab 10.3 MPI
```bash
sudo apt install -y openmpi-bin libopenmpi-dev
mpirun -np 4 hostname
mpirun -np 4 --host node1:2,node2:2 hostname
```

## Lab 10.4 Multi-GPU communication (GPU servers)
Build and run **nccl-tests** (`all_reduce_perf -b 8 -e 1G -f 2 -g <ngpus>`). Study NVLink, NVSwitch, InfiniBand, GPUDirect RDMA.

## Concepts
Head node, compute node, login node, scheduler, partitions, fair-share, job arrays, parallel filesystems (Lustre, BeeGFS, GPFS), Ceph.
