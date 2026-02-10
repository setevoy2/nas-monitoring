# FreeBSD NAS Monitoring

A collection of custom exporters, scripts, and Grafana dashboards for extended monitoring of a FreeBSD-based home NAS using VictoriaMetrics and the Prometheus ecosystem.

This repository contains practical, production-tested components used on a real FreeBSD NAS.

Read the following posts on the RTFM blog:

- [FreeBSD: Home NAS, part 10 – monitoring with VictoriaMetrics and Grafana](https://rtfm.co.ua/en/freebsd-home-nas-part-10-monitoring-with-victoriametrics-and-grafana/)
- [FreeBSD: Home NAS, part 11 – extended monitoring with additional exporters](https://rtfm.co.ua/en/freebsd-home-nas-part-11-extended-monitoring-with-additional-exporters/)

---

## Repository structure

```
├── exporters
│   ├── ecoflow_exporter
│   │   ├── rc.d
│   │   └── src
│   └── zfs_exporter
│       ├── rc.d
│       └── src
├── grafana
│   └── dashboards
└── node_exporter_textfile_scripts
```

## Exporters

### ecoflow_exporter

Custom exporter for EcoFlow power stations, exposing metrics such as power usage, battery level, and charging state.

Includes source code, build scripts, and an rc.d service for FreeBSD.

### zfs_exporter

Additional ZFS-related metrics not covered by standard exporters.

Includes source code, build scripts, and an rc.d service for FreeBSD.

---

## node_exporter textfile scripts

Scripts for the `node_exporter` textfile collector.  
They are intended to be executed periodically via `cron` and write metrics atomically.

### process_resources_exporter.sh

Exports:
- top processes by RSS memory usage
- top processes by CPU usage
- CPU/system temperature via ACPI

### service_status_exporter.sh

Exports service availability as:

```
service_up{name="service_name"} 1|0
```

Used for monitoring:
- jellyfin
- filebrowser
- grafana
- victoria-metrics
- sshd
- nfsd

### updates_exporter.sh

Exports update status:
- FreeBSD base system (`freebsd-update`)
- installed packages (`pkg`)

Useful for visibility and alerting when updates are pending.

---

## Grafana

Includes a ready-to-use dashboard `grafana/dashboards/nas-overview-full.json`:

Dashboard covers:
- CPU, memory, and swap usage
- ZFS pool and ARC statistics
- disk SMART status and temperatures
- service status panels
- custom textfile-based metrics

Designed for wall displays and long-term observability.

---

## Monitoring stack

- FreeBSD
- VictoriaMetrics
- vmagent / vmalert
- node_exporter
- smartctl_exporter
- Grafana

Minimal abstraction, no jails required.

---

## Purpose

This repository is intentionally opinionated.

Built for:
- FreeBSD-based home NAS systems
- self-hosted infrastructure
- users who prefer transparency over black-box solutions
- practical monitoring without unnecessary complexity

---


