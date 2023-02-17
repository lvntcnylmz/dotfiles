#!/bin/bash

system="$(uptime | awk '{print $3}' | tr -d \,)"
user=$(whoami)

echo "<big></big> ${user^}|$system"
