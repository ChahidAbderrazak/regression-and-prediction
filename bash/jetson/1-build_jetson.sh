#/bin/bash
#### -----------------------   PREPARING THE WORKSPACE  -------------------------------
docker system prune -f
. .env

# # go to the jetson folder
# cd bash/jetson
# ls 

echo "${APP_HOST_PORT}:${APP_SERVER_PORT}"
#### -----------------------   BUILDING THE PROJECT DOCKER  -------------------------------
# build  the the dev-envirnment container(s)
echo && echo "[${PROJECT_NAME}][Docker-Compose] Building the container(s)"
docker-compose  -p "${PROJECT_NAME}" -f docker-compose_jetson.yml up -d --build 
