#!/bin/bash
container_name="mms_slam_melodic_branch"  
image_name="joriswenyuli/mmsslam:melodic-cuda11.0.3"

if [ "$(docker ps -a -q -f name=$container_name)" ]; then
  docker stop $container_name
  docker rm $container_name
fi

docker run -it --name $container_name --gpus all \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v /home/wenyu/Downloads:/root/downloads \
            -v /media/wenyu/T7/dataset:/root/dataset \
            -v $(dirname $(dirname $(readlink -f "$0"))):/root/catkin_ws/src/$(basename $(dirname $(dirname "$(readlink -f "$0")"))) \
            -e DISPLAY=$DISPLAY $image_name bash
