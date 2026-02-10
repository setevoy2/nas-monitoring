#!/bin/sh

DIR="/var/tmp/node_exporter"
OUT="$DIR/service_status.prom"
TMP="$DIR/service_status.prom.tmp"

mkdir -p "$DIR"

# helpers
check_proc() {
  pgrep -f "$1" >/dev/null 2>&1
}

check_port() {
  host="$1"
  port="$2"
  nc -z "$host" "$port" >/dev/null 2>&1
}

# write metrics (atomic)
cat <<EOF > "$TMP"
# HELP service_up Service availability status (1=up, 0=down)
# TYPE service_up gauge
EOF

# jellyfin
if check_port 127.0.0.1 8096; then
  echo 'service_up{name="jellyfin"} 1' >> "$TMP"
else
  echo 'service_up{name="jellyfin"} 0' >> "$TMP"
fi

# filebrowser
if check_port 127.0.0.1 8080; then
  echo 'service_up{name="filebrowser"} 1' >> "$TMP"
else
  echo 'service_up{name="filebrowser"} 0' >> "$TMP"
fi

# grafana
if check_port 127.0.0.1 3000; then
  echo 'service_up{name="grafana"} 1' >> "$TMP"
else
  echo 'service_up{name="grafana"} 0' >> "$TMP"
fi

# victoria-metrics
if check_port 127.0.0.1 8428; then
  echo 'service_up{name="victoria-metrics"} 1' >> "$TMP"
else
  echo 'service_up{name="victoria-metrics"} 0' >> "$TMP"
fi

# sshd
if check_port 127.0.0.1 22; then
  echo 'service_up{name="sshd"} 1' >> "$TMP"
else
  echo 'service_up{name="sshd"} 0' >> "$TMP"
fi

# nfsd
if check_proc nfsd; then
  echo 'service_up{name="nfsd"} 1' >> "$TMP"
else
  echo 'service_up{name="nfsd"} 0' >> "$TMP"
fi

mv "$TMP" "$OUT"

