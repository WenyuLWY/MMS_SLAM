FROM nvidia/cuda:11.0.3-devel-ubuntu18.04

ARG DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

WORKDIR /root

#base
RUN apt-get update && apt-get install -y lsb-release curl wget vim

#ros
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    apt-get update && apt-get install -y ros-melodic-desktop-full && \
    apt-get install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool \
    build-essential python-rosdep python3-catkin-tools && \
    echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc 

#conda
RUN mkdir -p ~/miniconda3 && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh && \
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 && rm -rf ~/miniconda3/miniconda.sh && \
    bash -c "source /root/miniconda3/etc/profile.d/conda.sh && \ 
            conda init bash && \
            conda create -n solo python=3.7 -y && \
            conda activate solo && \
            conda install pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=11.0 -c pytorch && \
            conda install -c conda-forge addict rospkg pycocotools && \
            pip install alfred-py scipy==1.7.0 rich platformdirs==3.5.1 typing-extensions==4.7.1"   

# ros workspace
RUN mkdir -p /root/catkin_ws/src && \
    cd /root/catkin_ws && \
    bash -c "source /opt/ros/melodic/setup.bash && catkin build" && \
    echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

#ros package
RUN apt-get update && apt-get install -y \
    libceres-dev \
    libpcl-dev \
    ros-melodic-octomap* \
    ros-melodic-hector-trajectory-server 

# env 
RUN echo "conda activate solo" >> ~/.bashrc
RUN echo "#!/bin/bash" > /root/start.sh && \
    echo "cd /root/catkin_ws" >> /root/start.sh && \
    echo "source /opt/ros/melodic/setup.bash" >> /root/start.sh && \
    echo "source /root/catkin_ws/devel/setup.bash" >> /root/start.sh && \
    echo "catkin build" >> /root/start.sh && \
    echo "source /root/catkin_ws/devel/setup.bash" >> /root/start.sh && \
    echo "source /root/miniconda3/etc/profile.d/conda.sh" >> /root/start.sh && \
    echo "conda activate solo" >> /root/start.sh && \
    echo "roscd mms_slam" >> /root/start.sh && \
    echo "cd dependency/mmdet" >> /root/start.sh && \
    echo "python setup.py install" >> /root/start.sh && \
    echo "cd /root/catkin_ws" >> /root/start.sh && \
    echo "exec \"\$@\"" >> /root/start.sh && \
    chmod +x /root/start.sh
WORKDIR /root
ENTRYPOINT ["/root/start.sh"]
RUN ~/miniconda3/bin/conda init bash
CMD ["/bin/bash"]

