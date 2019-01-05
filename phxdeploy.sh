#!/bin/sh

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
PURPLE='\033[1;35m'
NC='\033[0m'

echo -e "\n####################################"
echo -e "### ${CYAN}Phoenix Deployment Script${NC}    ###"
echo "###                              ###"
echo -e "### by ${PURPLE}Ferdinand Saporas Bergado${NC} ###"
echo "####################################"


echo -e "\nScript started at: ${YELLOW} $(date)${NC} \n"
# Initial setup
echo -e "\n${GREEN}TASK ${CYAN}[1 of 4]${GREEN}: Fetching dependencies...${NC} \n"
time mix deps.get --only prod

echo -e "\n${GREEN}TASK ${CYAN}[2 of 4]${GREEN}: Compiling...${NC}\n"
time MIX_ENV=prod mix compile

# Compile assets
# cd assets && webpack --mode production && cd ..

# mix phx.digest

# Custom tasks (like DB migrations)
echo -e "\n${GREEN}TASK ${CYAN}[3 of 4]${GREEN}: Migrating database...${NC}\n"
time MIX_ENV=prod mix ecto.migrate

# Finally run the server
echo -e "\n${GREEN}TASK ${CYAN}[4 of 4]${GREEN}: Starting server...${NC}\n"
PORT=4001 MIX_ENV=prod mix phx.server
