#!/bin/bash

NOTIFY="/usr/bin/notify-send"
INTERFACE="wlan0"
SSID="Wu-Tang LAN"

# Function to send error and exit
error_exit() {
  $NOTIFY "  Wi-Fi Toggle Error" "$1"
  exit 1
}

# Disconnect
$NOTIFY "Wi-Fi Toggle" "󰖪  Disconnecting from Wi-Fi..."
if ! iwctl station "$INTERFACE" disconnect; then
  error_exit "Failed to disconnect from Wi-Fi."
fi

sleep 2

# Reconnect
$NOTIFY "Wi-Fi Toggle" "  Reconnecting to $SSID..."
if ! iwctl station "$INTERFACE" connect "$SSID"; then
  error_exit "Failed to connect to $SSID."
fi

sleep 2

# Check status
STATE=$(iwctl station "$INTERFACE" show | grep -w 'State' | awk '{$1=$1; print $2}')

$NOTIFY "Wi-Fi Toggle" "  $INTERFACE is now: $STATE"
