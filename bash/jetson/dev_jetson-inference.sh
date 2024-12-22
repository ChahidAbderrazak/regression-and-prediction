#!/bin/bash
. .env
command="bash "

#### -------------------------   RUN MLOPS SERVERS  ----------------------------
dir=$(pwd)
project_name="${PWD##*/}"

# run the mlops servers
jetson_inference_root=~/
cd $jetson_inference_root

# download the jetson-inference
if ! [[ -d jetson-inference ]]; then
  git clone --recursive --depth=1 https://github.com/dusty-nv/jetson-inference
fi
cd jetson-inference

# run the jetson container
echo && echo "[${PROJECT_NAME}][Docker][Jetson-inference] running the jetson-inference container..."
docker system prune -f
docker/run.sh --volume $dir:/jetson-inference/app/

# show all running dockers 
docker ps