# SelvaFM - Internet Radio Streaming Platform

SelvaFM is an Icecast-based audio streaming platform with a modern web interface and comprehensive streaming capabilities.

## Features

- Real-time audio streaming with responsive web player
- Direct stream connection support
- Bootstrap-powered responsive design
- Feather icons for intuitive UI
- Stream status and listener tracking
- Admin panel with stream statistics
- WebSocket-based real-time updates

## Migrating to Render.com

This project is configured for deployment on Render.com. Follow these steps to migrate:

### Step 1: Set up a Render account

- Sign up for a Render account at [render.com](https://render.com)
- Connect your GitHub/GitLab account or create a new repository

### Step 2: Prepare your repository

1. Clone this repository
2. Rename `render-package.json` to `package.json`
3. Ensure the `web` directory is included with all HTML/CSS/JS files
4. Push the repository to GitHub/GitLab

### Step 3: Deploy on Render

#### Option 1: Using render.yaml (Blueprint)

1. Push your repository to GitHub/GitLab
2. In Render dashboard, click "New" and select "Blueprint"
3. Connect your repository
4. Render will automatically detect the `render.yaml` file and set up the services

#### Option 2: Manual setup

1. In Render dashboard, click "New" and select "Web Service"
2. Connect your repository
3. Configure the service:
   - **Name**: selvafm-web
   - **Environment**: Node.js
   - **Build Command**: npm install
   - **Start Command**: node render-server.js
   - **Plan**: Free (or your preferred plan)
4. Add environment variables:
   - `PORT`: 10000
   - `ICECAST_HOST`: (Set to the address of your Icecast server)
   - `ICECAST_PORT`: 8010
   - `ICECAST_ADMIN_USER`: (your admin username)
   - `ICECAST_ADMIN_PASSWORD`: (your admin password)
   - `NODE_ENV`: production
5. Create a second web service for the Icecast server:
   - **Name**: selvafm-icecast
   - **Environment**: Docker
   - **Dockerfile Path**: ./Dockerfile.icecast
   - **Plan**: Free (or your preferred plan)
6. Add environment variables for the Icecast service:
   - `ICECAST_ADMIN_USER`: (your admin username)
   - `ICECAST_ADMIN_PASSWORD`: (your admin password)
   - `ICECAST_SOURCE_PASSWORD`: (your source password)
   - `ICECAST_RELAY_PASSWORD`: (your relay password)

### Step 4: Update WebSocket client configuration

In the web client files (`web/js/main.js` and `web/js/admin.js`), make sure the WebSocket connection uses the correct URL format:

```javascript
// Update this code in web/js/main.js
function connectWebSocket() {
    const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
    const wsUrl = `${protocol}//${window.location.host}/ws`;
    // ... rest of the function
}