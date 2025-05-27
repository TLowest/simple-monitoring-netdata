#!/bin/bash

# test_dashboard.sh - simulates system load to test Netdata alerts

set -e 

echo "[*] Generating CPU load for 1 minute ..."
timeout 60s bash -c 'while :; do :; done' &

echo "[*] Load generated. Please check the Netdata dashboard."
wait

