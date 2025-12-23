# 🌟 What is n8n?

n8n is a fair-code licensed workflow automation tool. It allows you to connect apps and services together to automate tasks and workflows. With n8n, you can:

- Automate repetitive tasks
- Connect APIs and services
- Build complex workflows with a visual interface
- Self-host your automation platform
- Extend functionality with custom nodes

# n8n Local Installation Guide

A comprehensive guide for installing n8n workflow automation tool locally on Windows, macOS, and Linux with automated installation and uninstallation scripts.

## 🚀 Quick Installation

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/install-n8n.ps1 | iex
```

Or download and run separately:
```powershell
irm https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/install-n8n.ps1 -OutFile install-n8n.ps1
.\install-n8n.ps1
```

### Linux/macOS (Bash)

```bash
curl -fsSL https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/install-n8n.sh | bash
```

Or download and run separately:
```bash
curl -fsSL https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/install-n8n.sh -o install-n8n.sh
chmod +x install-n8n.sh
./install-n8n.sh
```

## 🗑️ Quick Uninstallation

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/uninstall-n8n.ps1 | iex
```

Or download and run separately:
```powershell
irm https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/uninstall-n8n.ps1 -OutFile uninstall-n8n.ps1
.\uninstall-n8n.ps1
```

### Linux/macOS (Bash)

```bash
curl -fsSL https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/uninstall-n8n.sh | bash
```

Or download and run separately:
```bash
curl -fsSL https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/uninstall-n8n.sh -o uninstall-n8n.sh
chmod +x uninstall-n8n.sh
./uninstall-n8n.sh
```

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Installation Methods](#installation-methods)
  - [Automated Scripts (Recommended)](#automated-scripts-recommended)
  - [Manual Installation](#manual-installation)
  - [Docker Installation](#docker-installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Uninstalling n8n](#uninstalling-n8n)
  - [Automated Uninstallation (Recommended)](#automated-uninstallation-recommended)
  - [Manual Uninstallation](#manual-uninstallation)
- [Updating n8n](#updating-n8n)
- [Troubleshooting](#troubleshooting)
- [Additional Resources](#additional-resources)

## ✅ Prerequisites

- **Node.js** version 18.10 or newer
- **npm** (comes with Node.js)
- At least 4GB RAM recommended
- Modern web browser (Chrome, Firefox, Edge, Safari)

## 📦 Installation Methods

### Automated Scripts (Recommended)

The easiest way to install n8n is using our automated scripts. These scripts handle everything automatically:

#### Windows Installation

1. **Open PowerShell as Administrator**

2. **Allow script execution** (one-time setup):
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   ```

3. **Download and run the installation script**:
   ```powershell
   irm https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/install-n8n.ps1 -OutFile install-n8n.ps1
   .\install-n8n.ps1
   ```
   
   Or run directly:
   ```powershell
   irm https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/install-n8n.ps1 | iex
   ```

**What the Windows script does:**
- ✅ Checks for administrator privileges
- ✅ Detects existing Node.js installation
- ✅ Installs Node.js automatically using winget (if missing)
- ✅ Validates Node.js version (18.10+)
- ✅ Installs n8n globally via npm
- ✅ Verifies successful installation
- ✅ Offers to start n8n immediately

#### macOS Installation

1. **Open Terminal**

2. **Download and run the installation script**:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/install-n8n.sh -o install-n8n.sh
   chmod +x install-n8n.sh
   ./install-n8n.sh
   ```

**What the macOS script does:**
- ✅ Detects macOS automatically
- ✅ Checks for existing Node.js installation
- ✅ Installs Node.js using Homebrew (if missing)
- ✅ Installs Homebrew if not present
- ✅ Validates Node.js version (18.10+)
- ✅ Installs n8n globally via npm
- ✅ Verifies successful installation
- ✅ Offers to start n8n immediately

#### Linux Installation

1. **Open Terminal**

2. **Download and run the installation script**:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/install-n8n.sh -o install-n8n.sh
   chmod +x install-n8n.sh
   ./install-n8n.sh
   ```

**What the Linux script does:**
- ✅ Auto-detects your Linux distribution
- ✅ Checks for existing Node.js installation
- ✅ Installs Node.js using your package manager:
  - **Ubuntu/Debian**: apt-get
  - **Fedora/RHEL/CentOS**: dnf
  - **Arch Linux**: pacman
- ✅ Validates Node.js version (18.10+)
- ✅ Handles sudo permissions automatically
- ✅ Installs n8n globally via npm
- ✅ Verifies successful installation
- ✅ Offers to start n8n immediately

### Manual Installation

#### Windows

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

#### macOS

**Using Homebrew:**
```bash
# Install Node.js
brew install node

# Install n8n
npm install n8n -g

# Start n8n
n8n
```

**Quick Start with npx:**
```bash
npx n8n
```

#### Linux

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

### Docker Installation

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
      - N8N_BASIC_AUTH_PASSWORD=changeme
    volumes:
      - ~/.n8n:/home/node/.n8n
```

Run with:
```bash
docker-compose up -d
```

## 🎯 Quick Start

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

## ⚙️ Configuration

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

## 🗑️ Uninstalling n8n

### Automated Uninstallation (Recommended)

We provide automated uninstallation scripts that safely remove n8n and optionally backup your data.

#### Windows Uninstallation

```powershell
# Download and run
irm https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/uninstall-n8n.ps1 -OutFile uninstall-n8n.ps1
.\uninstall-n8n.ps1
```

Or run directly:
```powershell
irm https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/uninstall-n8n.ps1 | iex
```

**What the Windows uninstall script does:**
- ✅ Checks if n8n is currently running
- ✅ Offers to stop running n8n process
- ✅ Uninstalls n8n package globally
- ✅ **Creates automatic timestamped backup** of your data folder
- ✅ Prompts for confirmation before removing data
- ✅ Optional npm cache cleanup
- ✅ Provides detailed uninstallation summary

#### macOS Uninstallation

```bash
# Download and run
curl -fsSL https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/uninstall-n8n.sh -o uninstall-n8n.sh
chmod +x uninstall-n8n.sh
./uninstall-n8n.sh
```

**What the macOS uninstall script does:**
- ✅ Checks if n8n is currently running
- ✅ Offers to stop running n8n process
- ✅ Uninstalls n8n package globally
- ✅ **Creates automatic timestamped backup** of your data folder
- ✅ Prompts for confirmation before removing data
- ✅ Optional npm cache cleanup
- ✅ Provides detailed uninstallation summary

#### Linux Uninstallation

```bash
# Download and run
curl -fsSL https://raw.githubusercontent.com/venkateshk111/n8n-installation/main/uninstall-n8n.sh -o uninstall-n8n.sh
chmod +x uninstall-n8n.sh
./uninstall-n8n.sh
```

**What the Linux uninstall script does:**
- ✅ Checks if n8n is currently running
- ✅ Offers to stop running n8n process
- ✅ Uninstalls n8n package globally
- ✅ Handles sudo permissions automatically
- ✅ **Creates automatic timestamped backup** of your data folder
- ✅ Prompts for confirmation before removing data
- ✅ Optional npm cache cleanup
- ✅ Provides detailed uninstallation summary

### Manual Uninstallation

If you prefer to uninstall manually:

**Stop n8n** (if running):
- Press `Ctrl+C` in the terminal where n8n is running

**Uninstall n8n package:**

```bash
# Windows, macOS, Linux
npm uninstall n8n -g

# Linux (if permission error)
sudo npm uninstall n8n -g
```

**Remove data folder** (⚠️ WARNING: This deletes all workflows, credentials, and execution history!):

```powershell
# Windows PowerShell
Remove-Item -Path "$env:USERPROFILE\.n8n" -Recurse -Force
```

```bash
# macOS/Linux
rm -rf ~/.n8n
```

**Optional - Clear npm cache:**

```bash
npm cache clean --force
```

> **Important**: The data folder contains all your workflows, credentials, and execution history. **Always backup** this folder before deletion if you want to preserve your work!

## 🔄 Updating n8n

### Using npm

```bash
npm update n8n -g
```

### Using Docker

```bash
docker pull docker.n8n.io/n8nio/n8n
```

### Check current version

```bash
n8n --version
```

## 🔧 Troubleshooting

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

### Script Execution Issues (Windows)

If you get an error about script execution being disabled:
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

### n8n Command Not Found After Installation

**Windows:**
1. Close and reopen PowerShell
2. Or restart your computer to refresh environment variables

**macOS/Linux:**
1. Close and reopen Terminal
2. Or reload your shell: `source ~/.bashrc` or `source ~/.zshrc`

## 📚 Additional Resources

- [Official Documentation](https://docs.n8n.io/)
- [Community Forum](https://community.n8n.io/)
- [GitHub Repository](https://github.com/n8n-io/n8n)
- [Workflow Templates](https://n8n.io/workflows/)
- [YouTube Tutorials](https://www.youtube.com/c/n8n-io)
- [n8n Blog](https://blog.n8n.io/)

## 📁 Repository Structure

```
n8n-installation/
├── README.md              # This file - Complete installation guide
├── install-n8n.ps1        # Windows PowerShell installation script
├── install-n8n.sh         # Linux/macOS Bash installation script
├── uninstall-n8n.ps1      # Windows PowerShell uninstallation script
├── uninstall-n8n.sh       # Linux/macOS Bash uninstallation script
└── LICENSE                # License information
```

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Test your changes on the target platform
4. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
5. Push to the branch (`git push origin feature/AmazingFeature`)
6. Open a Pull Request

### Contribution Ideas

- Test scripts on different OS versions
- Add support for more Linux distributions
- Improve error handling
- Add more configuration examples
- Translate documentation
- Report bugs or issues

## 📝 License

This installation guide and scripts are provided as-is for the community. n8n itself is licensed under the [Sustainable Use License](https://github.com/n8n-io/n8n/blob/master/LICENSE.md).

## ⭐ Support

If you found this helpful, please give it a star! ⭐

### Need Help?

- 🐛 **Found a bug?** Open an issue in this repository
- 💬 **Have questions?** Visit the [n8n Community Forum](https://community.n8n.io/)
- 📧 **Script issues?** Open an issue with details about your OS and error message

## 🎯 Features

### Installation Scripts
- ✅ Automatic Node.js detection and installation
- ✅ Version validation (Node.js 18.10+)
- ✅ Cross-platform support (Windows, macOS, Linux)
- ✅ Color-coded output for better readability
- ✅ Error handling with helpful messages
- ✅ Post-installation verification
- ✅ Option to start n8n immediately

### Uninstallation Scripts
- ✅ Automatic backup creation before data deletion
- ✅ Running process detection and termination
- ✅ Confirmation prompts for safety
- ✅ Optional npm cache cleanup
- ✅ Detailed summary of removed items
- ✅ Data preservation options

## 🔐 Security Notes

- Never run scripts from untrusted sources
- Review scripts before execution (they're open source!)
- Keep your Node.js and n8n updated
- Use strong passwords for n8n authentication
- Don't expose n8n directly to the internet without proper security

---

<!--
[![GitHub Stars](https://img.shields.io/github/stars/n8n-io/n8n?style=social)](https://github.com/n8n-io/n8n)
[![GitHub Forks](https://img.shields.io/github/forks/n8n-io/n8n?style=social)](https://github.com/n8n-io/n8n)
[![GitHub Watchers](https://img.shields.io/github/watchers/n8n-io/n8n?style=social)](https://github.com/n8n-io/n8n)
[![GitHub Issues](https://img.shields.io/github/issues/n8n-io/n8n?style=social)](https://github.com/n8n-io/n8n/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/n8n-io/n8n?style=social)](https://github.com/n8n-io/n8n/pulls)
[![GitHub Repo Size](https://img.shields.io/github/repo-size/n8n-io/n8n?style=social)](https://github.com/n8n-io/n8n)
-->