#!/bin/bash

# n8n Uninstallation Script for Linux/macOS
# Usage: chmod +x uninstall-n8n.sh && ./uninstall-n8n.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

echo -e "${CYAN}=== n8n Uninstallation Script for Linux/macOS ===${NC}"
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if n8n is installed
echo -e "${YELLOW}Checking for n8n installation...${NC}"
if ! command_exists n8n; then
    echo -e "${GREEN}✓ n8n is not installed on this system${NC}"
    echo ""
    read -p "Would you like to check for n8n data folder? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}Uninstallation complete!${NC}"
        exit 0
    fi
else
    N8N_VERSION=$(n8n --version 2>/dev/null || echo "unknown")
    echo -e "${CYAN}Found n8n installation: ${N8N_VERSION}${NC}"
    echo ""
fi

# Check if n8n is running
echo -e "${YELLOW}Checking if n8n is currently running...${NC}"
N8N_PID=$(pgrep -f "n8n" || echo "")
if [ -n "$N8N_PID" ]; then
    echo -e "${YELLOW}⚠ n8n is currently running (PID: ${N8N_PID})${NC}"
    read -p "Do you want to stop it? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        kill -9 $N8N_PID 2>/dev/null || sudo kill -9 $N8N_PID
        echo -e "${GREEN}✓ Stopped n8n process${NC}"
        sleep 2
    else
        echo -e "${YELLOW}⚠ Please stop n8n before uninstalling${NC}"
        exit 1
    fi
fi
echo ""

# Uninstall n8n
if command_exists n8n; then
    echo -e "${YELLOW}Uninstalling n8n...${NC}"
    
    # Try without sudo first
    if npm uninstall n8n -g 2>/dev/null; then
        echo -e "${GREEN}✓ n8n uninstalled successfully!${NC}"
    else
        # Try with sudo
        echo -e "${YELLOW}Attempting uninstall with sudo...${NC}"
        if sudo npm uninstall n8n -g; then
            echo -e "${GREEN}✓ n8n uninstalled successfully!${NC}"
        else
            echo -e "${RED}✗ Failed to uninstall n8n${NC}"
            echo ""
            echo -e "${YELLOW}Try running manually:${NC}"
            echo -e "${CYAN}sudo npm uninstall n8n -g${NC}"
            exit 1
        fi
    fi
fi

# Handle data folder
echo ""
echo -e "${CYAN}=== Data Folder Management ===${NC}"
DATA_FOLDER="$HOME/.n8n"

if [ -d "$DATA_FOLDER" ]; then
    echo -e "${CYAN}Found n8n data folder at: ${DATA_FOLDER}${NC}"
    echo ""
    echo -e "${YELLOW}This folder contains:${NC}"
    echo -e "${WHITE}  - All your workflows${NC}"
    echo -e "${WHITE}  - Credentials${NC}"
    echo -e "${WHITE}  - Execution history${NC}"
    echo -e "${WHITE}  - Database${NC}"
    echo ""
    echo -e "${RED}⚠ WARNING: This action cannot be undone!${NC}"
    echo ""
    
    read -p "Do you want to remove the data folder? (yes/no): " -r
    if [[ $REPLY == "yes" || $REPLY == "YES" ]]; then
        echo ""
        echo -e "${YELLOW}Creating backup before deletion...${NC}"
        BACKUP_FOLDER="$HOME/.n8n_backup_$(date +%Y%m%d_%H%M%S)"
        
        if cp -r "$DATA_FOLDER" "$BACKUP_FOLDER"; then
            echo -e "${GREEN}✓ Backup created at: ${BACKUP_FOLDER}${NC}"
            echo ""
            
            read -p "Backup created. Proceed with deletion? (yes/no): " -r
            if [[ $REPLY == "yes" || $REPLY == "YES" ]]; then
                rm -rf "$DATA_FOLDER"
                echo -e "${GREEN}✓ Data folder removed successfully${NC}"
            else
                echo -e "${GREEN}✓ Data folder kept. Backup available at: ${BACKUP_FOLDER}${NC}"
            fi
        else
            echo -e "${RED}✗ Error creating backup${NC}"
            exit 1
        fi
    else
        echo -e "${GREEN}✓ Data folder kept at: ${DATA_FOLDER}${NC}"
    fi
else
    echo -e "${GRAY}No n8n data folder found at: ${DATA_FOLDER}${NC}"
fi

# Clear npm cache (optional)
echo ""
read -p "Would you like to clear npm cache? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Clearing npm cache...${NC}"
    npm cache clean --force
    echo -e "${GREEN}✓ npm cache cleared${NC}"
fi

# Summary
echo ""
echo -e "${GREEN}=== Uninstallation Complete ===${NC}"
echo ""
echo -e "${CYAN}Summary:${NC}"
echo -e "${GREEN}  ✓ n8n package removed${NC}"
if [ -d "$DATA_FOLDER" ]; then
    echo -e "${CYAN}  ℹ Data folder retained at: ${DATA_FOLDER}${NC}"
else
    echo -e "${GREEN}  ✓ Data folder removed${NC}"
fi
echo ""
echo -e "${CYAN}To reinstall n8n in the future, run:${NC}"
echo -e "${WHITE}  npm install n8n -g${NC}"
echo ""