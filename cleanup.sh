#!/bin/bash

# cleanup.sh - removes Netdata from the system

set -e

echo "[*] Stopping and disabling Netdata..."
sudo systemctl stop netdata 2>/dev/null || true
sudo systemctl disable netdata 2>/dev/null || true

echo "[*] Purging APT-based Netdata install (if any)..."
sudo apt purge netdata -y 2>/dev/null || true
sudo apt autoremove -y 2>/dev/null || true

echo "[*] Removing Netdata directories (kickstart or hybrid installs)..."
sudo rm -rf \
	/etc/netdata \
	/opt/netdata \ 
	/usr/lib/netdata \
	/var/lib/netdata \
	/var/log/netdata \
	/var/cache/netdata

echo "[*] Removing Netdata user and group..."
sudo userdel netdata 2>/dev/null || true
sudo groupdel netdata 2>/dev/null || true

echo "[*] Removing firewall rule..."
if command -v ufw &>/dev/null; then
	sudo ufw delete allow 19999/tcp
elif command -v firewall-cmd &>/dev/null; then
	sudo firewall-cmd --permanent --remove-port=19999/tcp
	sudo firewall-cmd --reload
fi

echo "[*] Cleanup complete. Netdata has been fully removed." 
