FROM node:20-bookworm

# Create and switch to an isolated app directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    ffmpeg \
    imagemagick \
    webp && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

# Copy package configurations first to utilize caching layers
COPY package.json .

# Install node dependencies bypassing peer conflicts
RUN npm install --legacy-peer-deps && npm install qrcode-terminal --legacy-peer-deps

# Copy the rest of the application files safely into /app
COPY . .

EXPOSE 3000

CMD ["node", "index.js", "--server"]
