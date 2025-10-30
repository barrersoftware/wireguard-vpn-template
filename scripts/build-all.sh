#!/bin/bash
# Build all VPN packages (APK + DEB)

set -e

echo "🚀 Building WireGuard VPN from Template"
echo "========================================"
echo ""

# Check if config exists
if [ ! -f "vpn-config.json" ]; then
    echo "❌ vpn-config.json not found!"
    echo "   Copy vpn-config.json.example and customize it"
    exit 1
fi

# Check if keys are generated
if grep -q "GENERATE_NEW_KEY" vpn-config.json; then
    echo "❌ Keys not generated!"
    echo "   Run: ./scripts/generate-keys.sh"
    exit 1
fi

echo "✅ Configuration valid"
echo ""

# Create releases directory
mkdir -p releases

# Build Android APK
echo "📱 Building Android APK..."
if [ -x "scripts/build-apk.sh" ]; then
    ./scripts/build-apk.sh
else
    echo "⚠️  build-apk.sh not found, skipping Android build"
fi

echo ""

# Build Linux client
echo "🐧 Building Linux client..."
if [ -x "scripts/build-linux-client.sh" ]; then
    ./scripts/build-linux-client.sh
else
    echo "⚠️  build-linux-client.sh not found, skipping Linux client build"
fi

echo ""

# Build Linux server
echo "🖥️  Building Linux server..."
if [ -x "scripts/build-linux-server.sh" ]; then
    ./scripts/build-linux-server.sh
else
    echo "⚠️  build-linux-server.sh not found, skipping Linux server build"
fi

echo ""
echo "========================================" 
echo "🎉 Build Complete!"
echo ""
echo "📦 Packages created in releases/"
ls -lh releases/
echo ""
echo "Next steps:"
echo "1. Test the packages"
echo "2. Setup your VPN server"
echo "3. Distribute to users"
