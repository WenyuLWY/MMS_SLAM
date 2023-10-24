# MMS-SLAM
## Multi-modal semantic SLAM in dynamic environments (Intel Realsense L515 as an example)

This code is modified from [MMS_SLAM](https://github.com/wh200720041/MMS_SLAM) 

add dockerfile

**Modifier:** Wenyu Li, HKUST

clone the repository and checkout to melodic_bench branch

```
git clone https://github.com/WenyuLWY/MMS_SLAM.git

git checkout melodic_bench

bash build.sh
```

modify the Download and dataset path in run.sh, then

```
bash run.sh
```

Then in container, you could run the commands

```
roslaunch mms_slam mms_slam.launch
```

