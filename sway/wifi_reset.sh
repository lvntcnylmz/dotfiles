#!/bin/bash

# SCRIPT: iwlwifi Driver Reload
# This script stops NetworkManager, unloads and reloads the iwlwifi modules,
# and then restarts NetworkManager.
# It is used to reset a stuck Wi-Fi driver module that might be reporting "is in use".

echo "--- 1. Stopping NetworkManager service..."
sudo systemctl stop NetworkManager

echo "--- 2. Unloading iwldvm and iwlwifi modules..."
# Attempt to remove modules. Errors are expected (e.g., if they are still in use).
sudo modprobe -r iwlmvm 2>/dev/null
sudo modprobe -r iwlwifi 2>/dev/null

# Check if removal was successful (optional check, main goal is to proceed)
if [ $? -eq 0 ]; then
  echo "Modules successfully unloaded."
else
  echo "Module removal returned some errors (They might still be in use), proceeding..."
fi

echo "--- 3. Reloading iwlwifi and iwlmvm module..."
sudo modprobe iwlwifi
sudo modprobe iwlmvm

echo "--- 4. Restarting NetworkManager service..."
sudo systemctl start NetworkManager

echo "--- 5. Checking status (Waiting 2 seconds)..."
sleep 2
systemctl status NetworkManager | grep Active

echo "--- Operation complete. Please check the status of your wireless network."
