#!/bin/bash

# --- Colors ---
GOLD='\033[38;5;220m'
ORANGE='\033[38;5;208m'
DARK_ORANGE='\033[38;5;202m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# --- 1. Pre-Boot Sequence (The Chill Version) ---
clear
echo -e "${ORANGE}[ LOADING ]${NC} Warming up the circuits..."
sleep 0.3
echo -e "${ORANGE}[ LOADING ]${NC} Teaching the AI how to high-five..."
sleep 0.4
echo -e "${DARK_ORANGE}[ LOADING ]${NC} Overclocking the vibes..."
sleep 0.3
echo -e "${GREEN}[ DONE ]${NC} Logic centers are (mostly) functioning."
sleep 0.2
echo -e "${GREEN}[ READY ]${NC} Mokusei is caffeinated and ready."
sleep 0.5

# --- 2. The Golden Reveal ---
clear
echo -e "${BOLD}"
echo -e "${GOLD}  ███╗   ███╗ ██████╗ ██╗  ██╗██╗   ██╗███████╗███████╗██╗"
echo -e "${GOLD}  ████╗ ████║██╔═══██╗██║ ██╔╝██║   ██║██╔════╝██╔════╝██║"
echo -e "${ORANGE}  ██╔████╔██║██║   ██║█████╔╝ ██║   ██║███████╗█████╗  ██║"
echo -e "${ORANGE}  ██║╚██╔╝██║██║   ██║██╔═██╗ ██║   ██║╚════██║██╔══╝  ██║"
echo -e "${DARK_ORANGE}  ██║ ╚═╝ ██║╚██████╔╝██║  ██╗╚██████╔╝███████║███████╗██║"
echo -e "${DARK_ORANGE}  ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝"
echo -e "               ${GOLD}⚡ ${BOLD}M O K U S E I   A I ${NC}${GOLD}⚡${NC}"
echo -e "               ${ORANGE}${BOLD}───── By: ${GOLD}MicoDevPH ${ORANGE}─────${NC}"
echo -e "${ORANGE}  ──────────────────────────────────────────────────────────${NC}"

# --- 3. Status Checks ---
echo -e "${CYAN}[1/2]${NC} 🔍 Checking Mokusei Core..."
if [ -f .env ]; then
    echo -e "      ${GREEN}✅ Systems Nominal (.env found)${NC}"
else
    echo -e "      ${BOLD}⚠️  Core Offline: .env missing${NC}"
fi

echo -e "${CYAN}[2/2]${NC} 🚀 Initializing Neural Link..."
echo -e "      ${BLUE}Main API:   ${BOLD}http://localhost:8000${NC}"
echo -e "      ${BLUE}Docs/UI:    ${BOLD}http://localhost:8000/docs${NC}"
echo ""
echo -e "${PURPLE}--- INCOMING DATA STREAM ---${NC}"

# --- Execution ---
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
