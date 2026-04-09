#!/bin/bash
# Hermes WebUI startup script
# Restarts both the web server and the cloudflared tunnel
set -e
sudo systemctl restart hermes-webui
sudo systemctl restart hermes-webui-tunnel
sleep 8
TUNNEL_URL=$(grep -o 'https://[^ ]*trycloudflare.com' /tmp/cloudflared-tunnel.log | tail -1)
echo "Hermes WebUI: $TUNNEL_URL"
echo "Password: hermes-webui-pass-2026"
