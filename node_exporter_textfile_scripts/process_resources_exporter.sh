#!/bin/sh

OUT="/var/tmp/node_exporter/process_resources.prom"

# reset file once
{
  echo "# HELP local_process_memory_bytes resident memory size per process"
  echo "# TYPE local_process_memory_bytes gauge"

  echo "# HELP local_process_cpu_percent cpu usage percent per process"
  echo "# TYPE local_process_cpu_percent gauge"

  echo "# HELP node_cpu_temperature_celsius CPU/system temperature via ACPI"
  echo "# TYPE node_cpu_temperature_celsius gauge"
} > "$OUT"

# ----
# top processes by memory (aggregate by process name)
# ----
ps -axo comm,rss | grep -vE '^(idle|pagezero|kernel)' | awk '
{
  gsub(/ /,"_",$1)
  mem[$1] += $2
}
END {
  for (p in mem)
    printf "local_process_memory_bytes{process=\"%s\"} %d\n", p, mem[p] * 1024
}
' | sort -k2 -nr | head -10 >> "$OUT"

# ----
# top processes by cpu (aggregate by process name)
# ----
ps -axo comm,%cpu | grep -vE '^(idle|pagezero|kernel)' | awk '
{
  gsub(/ /,"_",$1)
  cpu[$1] += $2
}
END {
  for (p in cpu)
    printf "local_process_cpu_percent{process=\"%s\"} %.2f\n", p, cpu[p]
}
' | sort -k2 -nr | head -10 >> "$OUT"

# ----
# cpu temperature via ACPI
# ----
TEMP=$(sysctl -n hw.acpi.thermal.tz0.temperature 2>/dev/null | tr -d 'C')

if [ -n "$TEMP" ]; then
  echo "node_cpu_temperature_celsius $TEMP" >> "$OUT"
fi

