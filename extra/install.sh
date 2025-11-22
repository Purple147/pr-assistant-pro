#!/usr/bin/env bash
set -e
# Ubuntu/Debian installer for pr-assistant
sudo apt update
sudo apt install -y docker.io docker-compose git
git clone https://github.com/YOURUSER/pr-assistant-pro /opt/pr-assistant
cd /opt/pr-assistant
cp .env.example .env
# (User should edit .env to set secrets)
docker-compose up -d --build
echo "Installation complete. Check logs: docker-compose logs -f"
