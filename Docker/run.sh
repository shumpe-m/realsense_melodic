docker run --gpus all -it --rm \
    --device=/dev/video0:/dev/video0 \
    --device=/dev/video1:/dev/video1 \
    --device=/dev/video2:/dev/video2 \
    --device=/dev/video3:/dev/video3 \
    --device=/dev/video4:/dev/video4 \
    --device=/dev/video5:/dev/video5 \
    -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
    -v $HOME/realsense_melodic:/root/realsense_melodic \
    realsense-melodic bash
