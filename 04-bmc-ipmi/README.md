# 04 - BMC / IPMI (Out-of-band Management)

Full commands, scripts and a browser practice lab are in your repo:
https://github.com/kumar-narsaraju/ipmi-bmc-toolkit

## Commands to practise on a real server (local, in-band)
```bash
sudo apt install -y ipmitool
sudo modprobe ipmi_si ipmi_devintf
sudo ipmitool mc info
sudo ipmitool chassis status
sudo ipmitool sensor
sudo ipmitool sel list
sudo ipmitool lan print 1
sudo ipmitool fru
```
Remote (out-of-band): `ipmitool -I lanplus -H <bmc-ip> -U <user> -P <pass> chassis status`

Concepts: BMC, IPMI, Redfish, iDRAC/iLO/IPMI web UI, SOL (serial over LAN), KVM-over-IP, SEL, FRU, sensors.
Exercise: with the repo's practice lab, complete all Guided Labs.
