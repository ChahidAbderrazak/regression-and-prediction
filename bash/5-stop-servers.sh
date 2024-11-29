#/bin/bash
. .env
# get the name of the project docker image 
DOCKER_IMG="${IMG_BUILDER}:${VERSION}"

echo && echo "[${PROJECT_NAME}][Docker-Compose] Stopping all container(s)..."
docker-compose -p "${PROJECT_NAME}" -f docker-compose.yml stop

echo && echo "[${PROJECT_NAME}][Docker] Stopping all related container(s)..."

docker stop $(docker stop $(docker ps -a -q --filter ancestor=${DOCKER_IMG} --format="{{.ID}}"))
docker system prune -f

#### -------------------------   STOP MLOPS SERVERS  ----------------------------
dir=$(pwd)
project_name="${PWD##*/}"

# stop the mlops servers
mlops_dir=../MLOPs-template/
cd $mlops_dir
bash bash/stop-servers.sh


