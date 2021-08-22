#!/bin/bash

# Remove all files from /tmp and /var/tmp
rm -rf /tmp/* /var/tmp/*

# Clear apt cache
apt clear

# Clean thumbnails cache
rm -rf ~/.cache/thumbnails/*