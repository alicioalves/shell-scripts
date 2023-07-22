#!/bin/sh
# Set Up Swap Linux
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show

# Make the file permanent
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Set Swapinnes
sudo sysctl vm.swappiness=10
echo 'vm.swappiness = 10' | sudo tee -a /etc/sysctl.conf

# Set Cache Pressure
sudo sysctl vm.vfs_cache_pressure=50
echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf

