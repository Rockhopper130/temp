#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting application setup...${NC}"

# Install frontend dependencies
echo -e "${GREEN}Installing frontend dependencies...${NC}"
cd project
npm install

# Install backend dependencies
echo -e "${GREEN}Installing backend dependencies...${NC}"
cd ../Backend
npm install

# Start backend in background
echo -e "${GREEN}Starting backend server...${NC}"
node server.js &
BACKEND_PID=$!

# Start frontend
echo -e "${GREEN}Starting frontend development server...${NC}"
cd ../project
npm run dev

# Cleanup function to kill backend when script exits
cleanup() {
    echo -e "${BLUE}Shutting down servers...${NC}"
    kill $BACKEND_PID 2>/dev/null
    exit
}

trap cleanup EXIT INT TERM

