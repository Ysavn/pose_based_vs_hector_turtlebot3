#!/bin/bash

# to execute when in catkin_ws/src folder
sudo apt-get install ros-melodic-ros-control
sudo apt-get install ros-melodic-gazebo-ros-control
sudo apt-get install ros-melodic-unique-identifier
sudo apt-get install ros-melodic-geographic-info
sudo apt-get install ros-melodic-laser-geometry
sudo apt-get install ros-melodic-tf-conversions
sudo apt-get install ros-melodic-tf2-geometry-msgs
sudo apt-get install ros-melodic-joy

git clone -b kinetic-devel https://github.com/tu-darmstadt-ros-pkg/hector_quadrotor
git clone -b catkin https://github.com/tu-darmstadt-ros-pkg/hector_localization
git clone -b kinetic-devel https://github.com/tu-darmstadt-ros-pkg/hector_gazebo
git clone -b kinetic-devel https://github.com/tu-darmstadt-ros-pkg/hector_models
git clone -b catkin https://github.com/tu-darmstadt-ros-pkg/hector_slam

sed -i -e 's/option(USE_PROPULSION_PLUGIN "Use a model of the quadrotor propulsion system" ON)/option(USE_PROPULSION_PLUGIN "Use a model of the quadrotor propulsion system" OFF)/g' hector_quadrotor/hector_quadrotor_gazebo/urdf/CMakeLists.txt

sed -i -e 's/option(USE_AERODYNAMICS_PLUGIN "Use a model of the quadrotor aerodynamics" ON)/option(USE_AERODYNAMICS_PLUGIN "Use a model of the quadrotor aerodynamics" OFF)/g' hector_quadrotor/hector_quadrotor_gazebo/urdf/CMakeLists.txt

# this is to deactivate warnings
sed -i -e 's/add_dependencies(landing_action hector_uav_msgs_generate_message_cpp)//g' hector_quadrotor/hector_quadrotor_actions/CMakeLists.txt

sed -i -e 's/add_dependencies(pose_action hector_uav_msgs_generate_message_cpp)//g' hector_quadrotor/hector_quadrotor_actions/CMakeLists.txt

sed -i -e 's/add_dependencies(takeoff_action hector_uav_msgs_generate_message_cpp)//g' hector_quadrotor/hector_quadrotor_actions/CMakeLists.txt

sed -i -e 's/add_dependencies(hector_quadrotor_controllers hector_uav_msgs_generate_message_cpp)//g' hector_quadrotor/hector_quadrotor_controllers/CMakeLists.txt

cd ..
catkin_make
source devel/setup.bash
