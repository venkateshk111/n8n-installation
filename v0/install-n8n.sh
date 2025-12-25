#!/bin/bash

# n8n Installation Script for Linux/macOS
# Usage: chmod +x install-n8n.sh && ./install-n8n.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}=== n8n Installation Script for Linux/macOS ===${NC}"
echo ""

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo -e "${YELLOW}Detected OS: ${MACHINE}${NC}"
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to get Node.js version
get_node_version() {
    node --version 2>/dev/null | sed 's/v//' | cut -d'.' -f1,2
}

# Function to compare versions
version_ge() {
    printf '%s\n%s\n' "$2" "$1" | sort -V -C
}

# Check if Node.js is installed
echo -e "${YELLOW}Checking for Node.js installation...${NC}"
if command_exists node; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}✓ Node.js is already installed: ${NODE_VERSION}${NC}"
    
    # Check if version is adequate (v18.10+)
    CURRENT_VERSION=$(get_node_version)
    REQUIRED_VERSION="18.10"
    
    if ! version_ge "$CURRENT_VERSION" "$REQUIRED_VERSION"; then
        echo -e "${YELLOW}⚠ Warning: Node.js version should be 18.10 or higher${NC}"
        echo -e "${YELLOW}Current version: ${NODE_VERSION}${NC}"
        echo ""
        read -p "Do you want to continue anyway? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
else
    echo -e "${RED}✗ Node.js is not installed${NC}"
    echo ""
    echo -e "${YELLOW}Installing Node.js...${NC}"
    
    if [[ "$MACHINE" == "Mac" ]]; then
        # macOS installation
        if command_exists brew; then
            echo -e "${CYAN}Using Homebrew to install Node.js...${NC}"
            brew install node
            echo -e "${GREEN}✓ Node.js installed successfully!${NC}"
        else
            echo -e "${YELLOW}Homebrew not found. Installing Homebrew first...${NC}"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            brew install node
            echo -e "${GREEN}✓ Node.js installed successfully!${NC}"
        fi
    elif [[ "$MACHINE" == "Linux" ]]; then
        # Linux installation
        if command_exists apt-get; then
            # Debian/Ubuntu
            echo -e "${CYAN}Detected Debian/Ubuntu. Installing Node.js...${NC}"
            curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
            sudo apt-get install -y nodejs
            echo -e "${GREEN}✓ Node.js installed successfully!${NC}"
        elif command_exists dnf; then
            # Fedora/RHEL/CentOS
            echo -e "${CYAN}Detected Fedora/RHEL/CentOS. Installing Node.js...${NC}"
            curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
            sudo dnf install -y nodejs
            echo -e "${GREEN}✓ Node.js installed successfully!${NC}"
        elif command_exists pacman; then
            # Arch Linux
            echo -e "${CYAN}Detected Arch Linux. Installing Node.js...${NC}"
            sudo pacman -S --noconfirm nodejs npm
            echo -e "${GREEN}✓ Node.js installed successfully!${NC}"
        else
            echo -e "${RED}Could not detect package manager.${NC}"
            echo -e "${YELLOW}Please install Node.js manually from:${NC}"
            echo -e "${CYAN}https://nodejs.org/en/download/${NC}"
            echo ""
            echo -e "${YELLOW}Or use nvm (Node Version Manager):${NC}"
            echo -e "${CYAN}curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash${NC}"
            echo -e "${CYAN}nvm install --lts${NC}"
            exit 1
        fi
    fi
    
    # Verify Node.js installation
    if ! command_exists node; then
        echo -e "${RED}✗ Node.js installation verification failed${NC}"
        echo -e "${YELLOW}Please restart your terminal and run this script again${NC}"
        exit 1
    fi
fi

echo ""
echo -e "${YELLOW}Checking npm...${NC}"
if command_exists npm; then
    NPM_VERSION=$(npm --version)
    echo -e "${GREEN}✓ npm is installed: v${NPM_VERSION}${NC}"
else
    echo -e "${RED}✗ npm not found. Please reinstall Node.js${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Installing n8n globally...${NC}"
echo -e "${CYAN}This may take a few minutes...${NC}"

# Install n8n
if [[ "$EUID" -eq 0 ]]; then
    # Running as root
    npm install n8n -g
else
    # Not running as root, check if sudo is needed
    if npm install n8n -g 2>/dev/null; then
        echo -e "${GREEN}✓ n8n installed successfully!${NC}"
    else
        echo -e "${YELLOW}Installing with sudo...${NC}"
        sudo npm install n8n -g --unsafe-perm
    fi
fi

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ n8n installed successfully!${NC}"
else
    echo -e "${RED}✗ Failed to install n8n${NC}"
    echo ""
    echo -e "${YELLOW}Try running manually:${NC}"
    echo -e "${CYAN}sudo npm install n8n -g --unsafe-perm${NC}"
    exit 1
fi

# Verify n8n installation
echo ""
echo -e "${YELLOW}Verifying n8n installation...${NC}"
if command_exists n8n; then
    N8N_VERSION=$(n8n --version 2>/dev/null || echo "installed")
    echo -e "${GREEN}✓ n8n version: ${N8N_VERSION}${NC}"
else
    echo -e "${YELLOW}⚠ n8n command not found. You may need to restart your terminal.${NC}"
fi

echo ""
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo ""
echo -e "${CYAN}To start n8n, run:${NC}"
echo -e "  ${NC}n8n${NC}"
echo ""
echo -e "${CYAN}n8n will be accessible at: http://localhost:5678${NC}"
echo ""
echo -e "${NC}Data will be stored in: ~/.n8n${NC}"
echo ""

read -p "Would you like to start n8n now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo -e "${GREEN}Starting n8n...${NC}"
    echo -e "${CYAN}Access n8n at: http://localhost:5678${NC}"
    echo -e "${YELLOW}Press Ctrl+C to stop n8n${NC}"
    echo ""
    sleep 2
    n8n
else
    echo ""
    echo -e "${GREEN}Installation complete! Run 'n8n' whenever you're ready to start.${NC}"
fi