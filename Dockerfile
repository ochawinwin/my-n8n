# Start from the official n8n Docker image
FROM n8nio/n8n:latest

# Switch to root user to install system packages
USER root

# Install FFmpeg and clean up apt lists to reduce image size
RUN apk update && apk add --no-cache ffmpeg && rm -rf /var/cache/apk/*

# Switch back to the n8n user (node) for security best practices
# This user is created and used by the base n8n image
USER node

# You can add other n8n specific configurations here if needed
# For most basic setups, the base n8n image handles the CMD and entrypoint
