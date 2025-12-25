# n8n Local Installation Guide

A comprehensive guide for installing n8n workflow automation tool locally on Windows, macOS, and Linux.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation Methods](#installation-methods)
  - [Windows](#windows)
  - [macOS](#macos)
  - [Linux](#linux)
  - [Docker (All Platforms)](#docker-all-platforms)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)

## Prerequisites

- **Node.js** version 18.10 or newer
- **npm** (comes with Node.js)
- At least 4GB RAM recommended
- Modern web browser (Chrome, Firefox, Edge, Safari)

## Installation Methods

### Windows

#### Method 1: Automated PowerShell Script (Recommended)

1. Open PowerShell as Administrator
2. Allow script execution (one-time setup):
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   ```
3. Download and run the installation script:
   ```powershell
   # Download the script
   Invoke-WebRequest -Uri "https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/install-n8n.ps1" -OutFile "install-n8n.ps1"
   
   # Run the script
   .\install-n8n.ps1
   ```

#### Method 2: Manual Installation

1. **Install Node.js**
   - Download from [nodejs.org](https://nodejs.org/)
   - Run the installer and follow the prompts
   - Verify installation:
     ```powershell
     node --version
     npm --version
     ```

2. **Install n8n**
   ```powershell
   npm install n8n -g
   ```

3. **Start n8n**
   ```powershell
   n8n
   ```

#### Method 3: Using winget

```powershell
# Install Node.js
winget install OpenJS.NodeJS.LTS

# Install n8n
npm install n8n -g

# Start n8n
n8n
```

### macOS

#### Method 1: Using Homebrew (Recommended)

```bash
# Install Node.js
brew install node

# Install n8n
npm install n8n -g

# Start n8n
n8n
```

#### Method 2: Quick Start with npx

```bash
npx n8n
```

#### Method 3: Automated Script

```bash
# Download and run installation script
curl -O https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/install-n8n.sh
chmod +x install-n8n.sh
./install-n8n.sh
```

### Linux

#### Method 1: Using Package Manager

**Ubuntu/Debian:**
```bash
# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install n8n
sudo npm install n8n -g

# Start n8n
n8n
```

**Fedora/RHEL/CentOS:**
```bash
# Install Node.js
curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo dnf install -y nodejs

# Install n8n
sudo npm install n8n -g

# Start n8n
n8n
```

**Arch Linux:**
```bash
# Install Node.js
sudo pacman -S nodejs npm

# Install n8n
sudo npm install n8n -g

# Start n8n
n8n
```

#### Method 2: Quick Start with npx

```bash
npx n8n
```

### Docker (All Platforms)

#### Basic Docker Run

```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n
```

#### Using Docker Compose

Create a `docker-compose.yml` file:

```yaml
version: '3.8'

services:
  n8n:
    image: docker.n8n.io/n8nio/n8n
    container_name: n8n
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=<your-password-here>
    volumes:
      - ~/.n8n:/home/node/.n8n
```

Run with:
```bash
docker-compose up -d
```

## Quick Start

1. **Start n8n**
   ```bash
   n8n
   ```

2. **Access the interface**
   - Open your browser and navigate to: `http://localhost:5678`

3. **Create your account**
   - On first launch, you'll be prompted to create an owner account
   - Fill in your details and set a password

4. **Create your first workflow**
   - Click "Add workflow"
   - Start building automation by adding nodes

## Configuration

### Environment Variables

Create a `.env` file or set environment variables:

```bash
# Change the port
export N8N_PORT=5678

# Set custom data folder
export N8N_USER_FOLDER=~/.n8n

# Enable basic authentication
export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER=your_username
export N8N_BASIC_AUTH_PASSWORD=your_password

# Timezone
export GENERIC_TIMEZONE=America/New_York

# Webhook URL (for production)
export WEBHOOK_URL=https://your-domain.com/
```

### Data Storage

By default, n8n stores data in:
- **Windows**: `C:\Users\YOUR_USERNAME\.n8n`
- **macOS/Linux**: `~/.n8n`

This includes:
- Workflows
- Credentials
- Execution history
- Database (SQLite by default)

### Using PostgreSQL (Optional)

For production use, PostgreSQL is recommended:

```bash
export DB_TYPE=postgresdb
export DB_POSTGRESDB_HOST=localhost
export DB_POSTGRESDB_PORT=5432
export DB_POSTGRESDB_DATABASE=n8n
export DB_POSTGRESDB_USER=n8n_user
export DB_POSTGRESDB_PASSWORD=your_password
```

## Troubleshooting

### Port Already in Use

If port 5678 is already in use:
```bash
export N8N_PORT=5679
n8n
```

### Permission Errors (Linux/macOS)

If you get permission errors during installation:
```bash
sudo npm install n8n -g --unsafe-perm
```

### Node.js Version Issues

Check your Node.js version:
```bash
node --version
```

If it's below 18.10, update Node.js:
- **Windows**: Download from [nodejs.org](https://nodejs.org/)
- **macOS**: `brew upgrade node`
- **Linux**: Use your package manager or [nvm](https://github.com/nvm-sh/nvm)

### Clear Cache and Reinstall

```bash
npm cache clean --force
npm uninstall n8n -g
npm install n8n -g
```

### Can't Access n8n in Browser

1. Check if n8n is running:
   ```bash
   # Windows
   netstat -ano | findstr :5678
   
   # macOS/Linux
   lsof -i :5678
   ```

2. Check firewall settings
3. Try accessing via `http://127.0.0.1:5678` instead of `localhost`

### Memory Issues

Increase Node.js memory limit:
```bash
export NODE_OPTIONS="--max-old-space-size=4096"
n8n
```

## Updating n8n

```bash
npm update n8n -g
```

Or for Docker:
```bash
docker pull docker.n8n.io/n8nio/n8n
```

## Uninstalling n8n

```bash
npm uninstall n8n -g
```

To remove data folder:
- **Windows**: Delete `C:\Users\YOUR_USERNAME\.n8n`
- **macOS/Linux**: `rm -rf ~/.n8n`

## Additional Resources

- [Official Documentation](https://docs.n8n.io/)
- [Community Forum](https://community.n8n.io/)
- [GitHub Repository](https://github.com/n8n-io/n8n)
- [Workflow Templates](https://n8n.io/workflows/)

## Contributing

Feel free to submit issues or pull requests to improve this installation guide.

## License

This installation guide is provided as-is for the community. n8n itself is licensed under the [Sustainable Use License](https://github.com/n8n-io/n8n/blob/master/LICENSE.md).

---
