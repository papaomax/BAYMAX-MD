# Use Node.js LTS on Debian Buster

FROM node:lts-buster

# Switch to root to install system packages

USER root

# Install dependencies: ffmpeg (media), webp (images), git (repo ops)

RUN apt-get update && \

    apt-get install -y ffmpeg webp git && \

    apt-get upgrade -y && \

    rm -rf /var/lib/apt/lists/*

# Switch back to the non-root "node" user for security

USER node

# Clone BAYMAX-MD repository

RUN git clone https://github.com/ridz-coder/BAYMAX-MD /home/node/BAYMAX-MD

# Set working directory

WORKDIR /home/node/BAYMAX-MD

# Install project dependencies

RUN yarn install --network-concurrency 1

# Expose the app port (change if your app uses another one)

EXPOSE 7860

# Set environment to production

ENV NODE_ENV=production

# Start the app

CMD ["npm", "start"]