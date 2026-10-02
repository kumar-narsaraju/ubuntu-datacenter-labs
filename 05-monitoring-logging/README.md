# 05 - Monitoring and Logging

## Lab 5.1 Logs
```bash
journalctl -f
journalctl --disk-usage
sudo journalctl --vacuum-time=7d
sudo nano /etc/systemd/journald.conf     # Storage=persistent
sudo systemctl restart systemd-journald
logger "hello from lab"
```
Configure logrotate: `/etc/logrotate.d/` , test `sudo logrotate -d /etc/logrotate.conf`.

## Lab 5.2 node_exporter
```bash
sudo apt install -y prometheus-node-exporter
curl -s localhost:9100/metrics | head
```

## Lab 5.3 Prometheus + Grafana
```bash
sudo apt install -y prometheus
sudo nano /etc/prometheus/prometheus.yml   # add target localhost:9100
sudo systemctl restart prometheus
```
Open `http://<vm-ip>:9090`, query `node_cpu_seconds_total`, `node_filesystem_avail_bytes`.
Install Grafana (see grafana.com docs), add Prometheus data source, import dashboard ID **1860** (Node Exporter Full).

## Lab 5.4 Alerts
Write a Prometheus alert for `node_filesystem_avail_bytes / node_filesystem_size_bytes < 0.1`.

## Concepts
Metrics vs logs vs traces, SNMP, syslog forwarding, SEL/BMC alerts, SLA/SLO, capacity planning.
