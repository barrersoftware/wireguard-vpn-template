#!/bin/bash
# Generate WireGuard keypairs for VPN

set -e

echo "🔑 Generating WireGuard Keys..."
echo ""

# Generate client keys
CLIENT_PRIVATE=$(wg genkey)
CLIENT_PUBLIC=$(echo "$CLIENT_PRIVATE" | wg pubkey)

# Generate server keys
SERVER_PRIVATE=$(wg genkey)
SERVER_PUBLIC=$(echo "$SERVER_PRIVATE" | wg pubkey)

echo "✅ Keys Generated!"
echo ""
echo "=== CLIENT KEYS ==="
echo "Private: $CLIENT_PRIVATE"
echo "Public:  $CLIENT_PUBLIC"
echo ""
echo "=== SERVER KEYS ==="
echo "Private: $SERVER_PRIVATE"
echo "Public:  $SERVER_PUBLIC"
echo ""

# Update config file
echo "📝 Updating vpn-config.json..."
if command -v jq &> /dev/null; then
    jq ".vpn.client_private_key = \"$CLIENT_PRIVATE\" | .vpn.server_public_key = \"$SERVER_PUBLIC\"" vpn-config.json > vpn-config.json.tmp
    mv vpn-config.json.tmp vpn-config.json
    echo "✅ Config updated!"
else
    echo "⚠️  Install 'jq' to auto-update config"
    echo "   Manually update vpn-config.json with above keys"
fi

echo ""
echo "=== SERVER CONFIGURATION ==="
echo "Add this peer to your server config:"
echo ""
echo "[Peer]"
echo "PublicKey = $CLIENT_PUBLIC"
echo "AllowedIPs = <client_ip>/32"
echo ""
echo "And use this for [Interface]:"
echo "PrivateKey = $SERVER_PRIVATE"
echo "PublicKey = $SERVER_PUBLIC"
echo ""
echo "🎉 Done! Run ./scripts/build-all.sh to build packages"
