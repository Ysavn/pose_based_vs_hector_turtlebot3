#!/usr/bin/env python

from __future__ import print_function

import roslib; roslib.load_manifest('teleop_twist_keyboard')
import rospy

from geometry_msgs.msg import Twist, PoseStamped

import sys, select, termios, tty

import time, datetime

def height_callback(data, pub):
    x = 0
    y = 0
    z = 0
    th = 0
    speed = 0.5
    turn = 1
    height = data.pose.position.z
    if height < 0.5:
        z = 1
    else:
        z = -1
    twist = Twist()
    twist.linear.x = x*speed; twist.linear.y = y*speed; twist.linear.z = z*speed;
    twist.angular.x = 0; twist.angular.y = 0; twist.angular.z = th*turn
    print(height, z)
    pub.publish(twist)


if __name__=="__main__":
    rospy.init_node('teleop_height_hector')
    pub = rospy.Publisher('cmd_vel', Twist, queue_size = 2)
    sub = rospy.Subscriber('ground_truth_to_tf/pose', PoseStamped, height_callback, pub)
    rospy.spin()