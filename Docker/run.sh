docker run --gpus all --rm -it  \
    -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
    -v $HOME/ur-Ubuntu18:/root/realsense-ubuntu18 \
    realsense-ubuntu18 bash
