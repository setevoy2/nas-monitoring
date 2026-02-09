#!/bin/sh

OUT="/var/tmp/node_exporter/updates.prom"

# header
{
  echo "# HELP node_freebsd_update_available FreeBSD base system updates available (1=yes, 0=no)"
  echo "# TYPE node_freebsd_update_available gauge"

  echo "# HELP node_pkg_updates_available Number of pkg updates available"
  echo "# TYPE node_pkg_updates_available gauge"
} > "$OUT"

# --------
# freebsd-update
# --------
FREEBSD_UPDATES=0

# freebsd-update fetch returns:
# - exit 0 even if no updates
# - but prints "No updates needed to update system"
if freebsd-update fetch | grep -q "No updates needed"; then
  FREEBSD_UPDATES=0
else
  FREEBSD_UPDATES=1
fi

echo "node_freebsd_update_available $FREEBSD_UPDATES" >> "$OUT"

# --------
# pkg updates
# --------
# pkg version -l "<" lists outdated packages
PKG_UPDATES=$(pkg version -l "<" 2>/dev/null | wc -l | tr -d ' ')

# fallback safety
PKG_UPDATES=${PKG_UPDATES:-0}

echo "node_pkg_updates_available $PKG_UPDATES" >> "$OUT"

