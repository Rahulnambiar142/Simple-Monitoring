#!/bin/bash

echo "Generating CPU load..."
# Use 'stress' to generate CPU load. Install it if needed: sudo apt-get install stress
stress --cpu 8 --timeout 60s &

echo "Generating disk I/O load..."
dd if=/dev/zero of=/tmp/testfile bs=1M count=1000 &

echo "Generating memory load..."
stress --vm 2 --vm-bytes 512M --timeout 60s &

echo "Load generation started. Monitor the dashboard at http://$(hostname -I | awk '{print $1}'):19999"

wait # Wait for background processes to finish.
echo "Load generation finished."
rm /tmp/testfile
