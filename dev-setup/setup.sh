#!/bin/bash
set -e

echo "🔧 Checking for Ansible..."
if ! command -v ansible &> /dev/null; then
    echo "📦 Installing Ansible..."
    if [ -f /etc/debian_version ]; then
        sudo apt update && sudo apt install -y ansible
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install -y ansible
    elif [ -f /etc/arch-release ]; then
        sudo pacman -Sy --noconfirm ansible
    else
        echo "❌ Unsupported distro. Please install Ansible manually."
        exit 1
    fi
fi

echo "📂 Installing Ansible roles from requirements.yml..."
ansible-galaxy install -r requirements.yml

echo "🚀 Running the Ansible playbook..."
ansible-playbook playbook.yml -i inventory.ini --ask-become-pass

echo "✅ Setup complete!"
