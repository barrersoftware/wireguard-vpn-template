# WireGuard VPN Template - Customizable Pre-Configured VPN

**Build your own branded WireGuard VPN with pre-configured tunnels**

This template allows companies to create a custom-branded WireGuard VPN app with pre-configured company settings. Users just install and connect - no manual configuration needed!

---

## 🎯 What This Template Provides

- ✅ **Automatic tunnel import** on first launch
- ✅ **Custom branding** (app name, package name)
- ✅ **Pre-configured settings** (keys, server, DNS)
- ✅ **Production-ready** build scripts
- ✅ **Easy customization** via configuration file

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/barrersoftware/wireguard-vpn-template.git
cd wireguard-vpn-template
```

### 2. Customize Your VPN

Edit `vpn-config.json`:

```json
{
  "company": {
    "name": "Your Company",
    "package": "com.yourcompany.vpn",
    "tunnel_name": "Company VPN"
  },
  "vpn": {
    "server_ip": "vpn.example.com",
    "server_port": "51820",
    "client_private_key": "GENERATE_NEW_KEY",
    "server_public_key": "GENERATE_NEW_KEY",
    "client_ip": "10.99.1.2/24",
    "allowed_ips": "10.0.0.0/8, 192.168.0.0/16",
    "dns": "1.1.1.1, 1.0.0.1"
  }
}
```

### 3. Generate Keys

```bash
./scripts/generate-keys.sh
```

This will generate new WireGuard keys and update your config file.

### 4. Build Your APK

```bash
./scripts/build-apk.sh
```

Output: `releases/yourcompany-vpn-signed.apk`

### 5. Build Linux Packages

```bash
./scripts/build-deb.sh
```

Output:
- `releases/yourcompany-vpn-client_1.0.0_amd64.deb`
- `releases/yourcompany-vpn-server_1.0.0_amd64.deb`

---

## 📦 What You Get

### Android APK
- Branded app name
- Auto-imports pre-configured tunnel
- Production signed
- Ready to distribute

### Linux Client DEB
- Pre-configured for your server
- Simple commands: `connect`, `disconnect`, `status`
- Zero-configuration needed

### Linux Server DEB
- Easy server setup
- Client management
- Automatic configuration

---

## 🔧 Customization Options

### Basic Customization

Edit `vpn-config.json`:

```json
{
  "company": {
    "name": "Acme Corp",                    // App display name
    "package": "com.acmecorp.vpn",          // Android package name
    "tunnel_name": "Acme Corporate VPN",    // Tunnel name in app
    "website": "https://acmecorp.com"       // Company website
  },
  "vpn": {
    "server_ip": "vpn.acmecorp.com",        // Your VPN server
    "server_port": "51820",                  // WireGuard port
    "client_private_key": "...",             // Auto-generated
    "server_public_key": "...",              // From your server
    "client_ip": "10.99.1.2/24",            // Client VPN IP
    "allowed_ips": "10.0.0.0/8",            // Routes through VPN
    "dns": "1.1.1.1, 1.0.0.1",              // DNS servers
    "persistent_keepalive": "25"             // Keep connection alive
  },
  "branding": {
    "app_icon": "assets/icon.png",          // Your app icon
    "primary_color": "#0066CC",              // Theme color
    "accent_color": "#00CC66"                // Accent color
  },
  "signing": {
    "keystore": "release.keystore",          // Your keystore
    "alias": "release",                      // Key alias
    "store_password": "ENV:KEYSTORE_PASS",   // From environment
    "key_password": "ENV:KEY_PASS"           // From environment
  }
}
```

### Advanced Customization

For advanced users, you can modify:
- **Source code:** `src/android/` and `src/linux/`
- **Build scripts:** `scripts/`
- **Templates:** `templates/`

---

## 🔐 Key Generation

### Automatic (Recommended)

```bash
./scripts/generate-keys.sh
```

This generates:
- Client private/public keypair
- Updates `vpn-config.json`
- Outputs server configuration

### Manual

```bash
# Generate keys
wg genkey | tee client_private.key | wg pubkey > client_public.key
wg genkey | tee server_private.key | wg pubkey > server_public.key

# Update vpn-config.json manually
```

---

## 🏗️ Building

### Prerequisites

**For Android:**
- Android SDK
- Java 17+
- Gradle

**For Linux:**
- dpkg-deb
- WireGuard tools

**Install dependencies:**
```bash
./scripts/install-dependencies.sh
```

### Build Everything

```bash
# Generate keys
./scripts/generate-keys.sh

# Build all packages
./scripts/build-all.sh
```

This creates:
- Android APK (signed)
- Linux client DEB (signed)
- Linux server DEB (signed)

### Build Individual Packages

```bash
# Android only
./scripts/build-apk.sh

# Linux client only
./scripts/build-linux-client.sh

# Linux server only
./scripts/build-linux-server.sh
```

---

## 📝 Configuration File Reference

### vpn-config.json

```json
{
  "company": {
    "name": "string",           // Required: App display name
    "package": "string",         // Required: Android package (reverse DNS)
    "tunnel_name": "string",     // Required: Tunnel name in app
    "website": "string",         // Optional: Company website
    "support_email": "string"    // Optional: Support email
  },
  "vpn": {
    "server_ip": "string",       // Required: VPN server IP/hostname
    "server_port": "number",     // Required: WireGuard port (default: 51820)
    "client_private_key": "string", // Auto-generated
    "server_public_key": "string",  // From your server setup
    "client_ip": "string",       // Required: Client VPN IP (CIDR)
    "allowed_ips": "string",     // Required: Routes through VPN
    "dns": "string",             // Optional: DNS servers
    "persistent_keepalive": "number" // Optional: Keepalive seconds
  },
  "branding": {
    "app_icon": "string",        // Path to app icon (1024x1024)
    "primary_color": "string",   // Hex color code
    "accent_color": "string"     // Hex color code
  },
  "signing": {
    "keystore": "string",        // Path to keystore file
    "alias": "string",           // Keystore alias
    "store_password": "string",  // Keystore password (use ENV:)
    "key_password": "string"     // Key password (use ENV:)
  }
}
```

---

## 🎨 Branding

### App Icon

Place your app icon at `assets/icon.png`:
- Size: 1024x1024 px
- Format: PNG
- Transparent background recommended

The build script will automatically generate all required sizes.

### App Name

Set in `vpn-config.json`:
```json
"company": {
  "name": "Your Company VPN"
}
```

### Package Name

Set in `vpn-config.json`:
```json
"company": {
  "package": "com.yourcompany.vpn"
}
```

**Important:** Use reverse domain notation (com.company.app)

---

## 🔑 Signing

### Android APK Signing

#### Create Keystore

```bash
keytool -genkey -v -keystore release.keystore \
  -alias release \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

#### Configure Signing

Update `vpn-config.json`:
```json
"signing": {
  "keystore": "release.keystore",
  "alias": "release",
  "store_password": "ENV:KEYSTORE_PASS",
  "key_password": "ENV:KEY_PASS"
}
```

#### Set Environment Variables

```bash
export KEYSTORE_PASS="your_keystore_password"
export KEY_PASS="your_key_password"
```

### Linux Package Signing

```bash
# Generate GPG key
gpg --full-generate-key

# Export for signing
gpg --export-secret-keys > signing.key
```

---

## 🚀 Deployment

### Android APK

**Option 1: Direct Distribution**
- Host APK on your website
- Share via internal portal
- Email to employees

**Option 2: Private App Store**
- Google Play Private Channel
- Enterprise MDM solution

**Option 3: F-Droid Repository**
- Set up private F-Droid repo
- Users install from your repo

### Linux Packages

**Option 1: APT Repository**
```bash
# Setup repository
./scripts/setup-repo.sh

# Users add repo
echo "deb https://repo.yourcompany.com focal main" | \
  sudo tee /etc/apt/sources.list.d/yourcompany-vpn.list
sudo apt update
sudo apt install yourcompany-vpn-client
```

**Option 2: Direct Download**
- Host DEB files on website
- Users download and install

---

## 📖 User Instructions

### Android

**Installation:**
1. Download APK
2. Enable "Unknown Sources"
3. Install APK
4. Open app
5. Tunnel auto-imports - just tap to connect!

**Usage:**
- Tap tunnel to connect/disconnect
- View stats by tapping connected tunnel
- Edit tunnel if needed

### Linux

**Installation:**
```bash
# Download and install
wget https://yourcompany.com/vpn-client.deb
sudo dpkg -i vpn-client.deb

# Or from repository
sudo apt install yourcompany-vpn-client
```

**Usage:**
```bash
# Connect
sudo yourcompany-vpn connect

# Disconnect
sudo yourcompany-vpn disconnect

# Check status
sudo yourcompany-vpn status
```

---

## 🔧 Server Setup

### Install WireGuard

```bash
sudo apt update
sudo apt install wireguard
```

### Configure Server

The build script outputs server configuration. Example:

```bash
sudo tee /etc/wireguard/wg0.conf << 'EOF'
[Interface]
PrivateKey = <server_private_key>
Address = 10.99.1.1/24
ListenPort = 51820
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
PublicKey = <client_public_key>
AllowedIPs = 10.99.1.2/32
EOF
```

### Start Server

```bash
sudo chmod 600 /etc/wireguard/wg0.conf
sudo wg-quick up wg0
sudo systemctl enable wg-quick@wg0
```

### Firewall

```bash
sudo ufw allow 51820/udp
sudo ufw reload
```

---

## 🧪 Testing

### Test APK

```bash
# Verify signature
./scripts/verify-apk.sh releases/yourcompany-vpn.apk

# Install on device
adb install releases/yourcompany-vpn.apk

# Check logs
adb logcat | grep VPN
```

### Test Linux Client

```bash
# Install package
sudo dpkg -i releases/yourcompany-vpn-client.deb

# Connect
sudo yourcompany-vpn connect

# Verify connection
ip addr show
ping 10.99.1.1
```

---

## 📚 Examples

### Example 1: Acme Corp

```json
{
  "company": {
    "name": "Acme VPN",
    "package": "com.acmecorp.vpn",
    "tunnel_name": "Acme Corporate Network"
  },
  "vpn": {
    "server_ip": "vpn.acmecorp.com",
    "server_port": "51820",
    "client_ip": "10.20.1.2/24",
    "allowed_ips": "10.20.0.0/16, 192.168.0.0/16",
    "dns": "10.20.1.1"
  }
}
```

### Example 2: Startup Inc

```json
{
  "company": {
    "name": "Startup VPN",
    "package": "com.startup.securevpn",
    "tunnel_name": "Startup Secure Access"
  },
  "vpn": {
    "server_ip": "51.15.241.123",
    "server_port": "51820",
    "client_ip": "10.8.0.2/24",
    "allowed_ips": "0.0.0.0/0",
    "dns": "1.1.1.1, 1.0.0.1"
  }
}
```

---

## 🐛 Troubleshooting

### Build Errors

**"Android SDK not found"**
```bash
export ANDROID_HOME=/path/to/android-sdk
```

**"Keystore not found"**
- Create keystore with `keytool`
- Update path in `vpn-config.json`

**"Permission denied"**
```bash
chmod +x scripts/*.sh
```

### Connection Issues

**"Can't connect"**
- Verify server is running
- Check firewall rules
- Verify keys match

**"No internet"**
- Check server NAT configuration
- Verify AllowedIPs setting
- Check DNS configuration

---

## 🤝 Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit pull request

---

## 📄 License

Based on WireGuard® by Jason A. Donenfeld  
Licensed under Apache 2.0

### Using This Template

You are free to:
- ✅ Use for commercial purposes
- ✅ Customize and rebrand
- ✅ Distribute your builds
- ✅ Modify source code

You must:
- ✅ Include original license
- ✅ Credit WireGuard®
- ✅ State modifications

---

## 🆘 Support

### Documentation
- GitHub Wiki
- Example configurations
- Video tutorials

### Community
- GitHub Discussions
- Issue tracker
- Discord server (coming soon)

### Commercial Support
- Email: support@barrersoftware.com
- Custom development available
- White-label solutions

---

## 🗺️ Roadmap

### v1.2 (Next Release)
- [ ] iOS support
- [ ] Windows client
- [ ] macOS client
- [ ] Web-based configurator

### v1.2 (Future)
- [ ] Multi-tunnel support
- [ ] QR code generation
- [ ] Auto-update functionality
- [ ] Analytics dashboard

---

## 🏆 Who's Using This

(Add your company here with a PR!)

- Barrer Software
- Your Company Here

---

## ⭐ Star This Project

If you find this useful, please star the repository!

---

**Built with ❤️ by Barrer Software**

*Making VPN deployment simple for everyone*
