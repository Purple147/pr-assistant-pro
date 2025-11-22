#!/usr/bin/env bash
set -e
sudo apt update
sudo apt install -y docker.io docker-compose git
sudo usermod -aG docker $USER
git clone https://github.com/Purple147/pr-assistant-pro /opt/pr-assistant
cd /opt/pr-assistant
cp .env.example .env
echo "Edit .env and then run: docker-compose up -d --build"
docker-compose up -d --build
