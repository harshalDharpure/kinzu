# Use Node.js 20 slim as the base image
FROM node:20-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies: ffmpeg, Python 3.11, pip, venv
RUN apt-get update && \
    apt-get install -y ffmpeg python3.11 python3.11-venv python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Copy only package files and requirements first for better caching
COPY kizunaback/package*.json ./kizunaback/
COPY kizunaback/requirements.txt ./kizunaback/

# Install Node.js dependencies
RUN cd kizunaback && npm install

# Create and activate a Python virtual environment
RUN python3.11 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r kizunaback/requirements.txt

# Copy the rest of your backend code
COPY kizunaback/ ./kizunaback/

# Set working directory to backend
WORKDIR /app/kizunaback

# Expose the port your app runs on
EXPOSE 5000

# Start the server
CMD ["npm", "start"] 