#!/bin/bash
set -e

echo "Starting Xvfb..."
Xvfb :0 -screen 0 ${RESOLUTION}x24 &
sleep 2

echo "Starting Window Manager..."
fluxbox &

echo "Starting VNC Server..."
# -forever: keep listening after client disconnects
# -shared: allow multiple clients
x11vnc -display :0 -forever -shared -nopw -quiet &

echo "Starting noVNC..."
# Proxy localhost:5900 (VNC) to port 6080
websockify --web /usr/share/novnc/ 6080 localhost:5900 &

echo "Starting VisualVM..."
# VisualVM needs to find the JDK. Usually works out of the box with the package,
# but passing --jdkhome ensures it picks the right one if multiple are present.
/tools/visualvm_22/bin/visualvm --jdkhome /usr/lib/jvm/java-17-openjdk-amd64
