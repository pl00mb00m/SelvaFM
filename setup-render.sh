#!/bin/bash
# SelvaFM setup script for Render.com deployment

echo "SelvaFM - Render.com Setup Script"
echo "================================="
echo

# Check if package.json exists
if [ -f "package.json" ]; then
  echo "Warning: package.json already exists."
  read -p "Do you want to replace it with render-package.json? (y/n): " replace_pkg
  if [ "$replace_pkg" = "y" ]; then
    mv render-package.json package.json
    echo "Replaced package.json with render-package.json"
  else
    echo "Keeping existing package.json"
  fi
else
  mv render-package.json package.json
  echo "Renamed render-package.json to package.json"
fi

echo
echo "Creating .env file for local development..."
cat > .env << EOL
# SelvaFM Environment Variables
PORT=10000
ICECAST_HOST=localhost
ICECAST_PORT=8010
ICECAST_ADMIN_USER=admin
ICECAST_ADMIN_PASSWORD=hackme
ICECAST_SOURCE_PASSWORD=hackme
ICECAST_RELAY_PASSWORD=hackme
NODE_ENV=development
EOL
echo "Created .env file with default values"

echo
echo "Checking for required directories..."
if [ ! -d "web" ]; then
  echo "Error: 'web' directory not found. Please ensure you have the web directory with all HTML/CSS/JS files."
  exit 1
fi

if [ ! -d "logs" ]; then
  mkdir -p logs
  echo "Created logs directory"
fi

if [ ! -d "streams" ]; then
  mkdir -p streams
  echo "Created streams directory"
fi

echo
echo "Checking for Dockerfile.icecast..."
if [ ! -f "Dockerfile.icecast" ]; then
  echo "Error: 'Dockerfile.icecast' not found. Make sure this file is present for Icecast deployment."
  exit 1
fi

echo
echo "Checking for render.yaml..."
if [ ! -f "render.yaml" ]; then
  echo "Error: 'render.yaml' not found. This file is required for Render Blueprint deployment."
  exit 1
fi

echo
echo "Setup complete!"
echo
echo "Next steps:"
echo "1. Install dependencies: npm install"
echo "2. Start server locally: node render-server.js"
echo "3. Deploy to Render.com following the instructions in README.md"
echo
echo "For more details, refer to the README.md file."