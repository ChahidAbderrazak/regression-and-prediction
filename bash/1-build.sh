#/bin/bash
#### -----------------------   PREPARING THE WORKSPACE  -------------------------------
docker system prune -f
. .env

#### -----------------------   BUILDING THE PROJECT DOCKER  -------------------------------
# build  the the dev-envirnment container(s)
echo && echo "[${PROJECT_NAME}][Docker-Compose] Building the container(s) [${PYTHON_VERSION}]"
docker-compose  -p "${PROJECT_NAME}" -f docker-compose.yml up -d --build 
