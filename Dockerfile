# Start from the official n8n Docker image
FROM n8nio/n8n:latest

# Switch to root user to install system packages
USER root

# Install FFmpeg and clean up apt lists to reduce image size
# RUN apk update && apk add --no-cache ffmpeg && rm -rf /var/cache/apk/*
RUN export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" && \
    if [ -x "$(command -v apt-get)" ]; then \
        apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*; \
    elif [ -x "$(command -v apk)" ]; then \
        apk add --no-cache ffmpeg; \
    else \
        echo "No package manager found! OS Details:" && cat /etc/os-release && exit 1; \
    fi

# Switch back to the n8n user (node) for security best practices
# This user is created and used by the base n8n image
USER node

# You can add other n8n specific configurations here if needed
# For most basic setups, the base n8n image handles the CMD and entrypoint
