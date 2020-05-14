# pose_based_vs_hector_turtlebot3

1. Create a new catkin workspace 

'''
$ mkdir -p ~/dr_ws/src
$ cd ~/dr_ws/
$ catkin_make
'''

2. Copy test_gazebo folder into src and do catkin_make

$ cp -r test_gazebo ~/dr_ws/src/
$ cd ~/dr_ws/
$ catkin_make

3. Install Turtlebot3 dependent packages

sudo apt-get install ros-melodic-joy ros-melodic-teleop-twist-joy ros-melodic-teleop-twist-keyboard ros-melodic-laser-proc ros-melodic-rgbd-launch ros-melodic-depthimage-to-laserscan ros-melodic-rosserial-arduino ros-melodic-rosserial-python ros-melodic-rosserial-server ros-melodic-rosserial-client ros-melodic-rosserial-msgs ros-melodic-amcl ros-melodic-map-server ros-melodic-move-base ros-melodic-urdf ros-melodic-xacro ros-melodic-compressed-image-transport ros-melodic-rqt-image-view ros-melodic-gmapping ros-melodic-navigation ros-melodic-interactive-markers


4. Install Turtlebot packages 
$ cd ~/dr_ws/src
$ git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
$ git clone -b melodic-devel https://github.com/ROBOTIS-GIT/turtlebot3.git
$ cd ~/dr_ws
$ catkin_make

5. Copy AR-Tag dependent files into appropriate locations along with modified Turtlebot3 model files
$ cp fd_avneet.dae ~/dr_ws/src/turtlebot3/turtlebot3_description/meshes/
$ cp MarkerData_1901.png ~/dr_ws/src/turtlebot3/turtlebot3_description/meshes/
$ cp turtlebot3_ar.urdf.xacro  ~/dr_ws/src/turtlebot3/turtlebot3_description/urdf/
$ cp turtlebot3_ar.gazebo.xacro ~/dr_ws/src/turtlebot3/turtlebot3_description/urdf/
$ cp willow_garage.world ~/dr_ws/src/hector_gazebo/hector_gazebo_worlds/worlds/

6. Install Hector packages
Note: First copy the script.sh file shared, in the src folder of dr_ws workspace. 
$ cd ~/dr_ws/src
$ bash script.sh

7. Install Ar-track-alvar package
$ sudo apt-get install ros-melodic-ar-track-alvar
$ Add /opt/ros/melodic/share/ar_track_alvar/launch/ar_tracker_hector_cam.launch

8. Create workspace for teleop-twist-keyboard and add my files
$ mkdir -p ~/teleop_twist/src
$ git clone https://github.com/ros-teleop/teleop_twist_keyboard.git
$ cd ../
$ catkin_make
$ Add following files in the location specified (With exec permissions): - 
  -> ~/teleop_twist/src/teleop_twist_hector_keyboard/teleop_height_hector.py
  -> ~/teleop_twist/src/teleop_twist_hector_keyboard/teleop_xy_hector.py

9. Run the Launch file for modified turtlebot3
$ source ~/dr_ws/devel/setup.bash
$ roslaunch test_gazebo main.launch

10. Run the hover Hector code
$ source ~/dr_ws/devel/setup.bash
$ rosservice call /enable_motors "enable: true"
$ rosrun teleop_twist_keyboard teleop_height_hector.py

11. Run the ar-track-alvar code
$ roslaunch ar_track_alvar ar_tracker_hector_cam.launch

12. Run image_view command to observe Hector's camera
$ rosrun image_view image_view image:=/front_cam/camera/image

13. Run the teleop-hector in XY plance code
$ rosrun teleop_twist_keyboard teleop_xy_hector.py

14. One can use keypress (w, a, s, d, and x) in the terminal window of main.launch to teleoperate the Turtlebot
