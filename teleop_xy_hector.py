#!/usr/bin/env python

from __future__ import print_function

import roslib; roslib.load_manifest('teleop_twist_keyboard')
import rospy

from geometry_msgs.msg import Twist, PoseStamped

from ar_track_alvar_msgs.msg import AlvarMarkers

import sys, select, termios, tty

import time, datetime

def xy_callback(markers, pub):
    x = 0
    y = 0
    z = 0
    th = 0
    speed = 20
    turn = 1

    for m in markers.markers:
        x = m.pose.pose.position.y*100
        twist = Twist()
        twist.linear.x = x*speed; twist.linear.y = y*speed; twist.linear.z = z*speed;
        twist.angular.x = 0; twist.angular.y = 0; twist.angular.z = th*turn
        print(x)
        for i in range(2):
            pub.publish(twist)

if __name__=="__main__":
    pub = rospy.Publisher('cmd_vel', Twist, queue_size = 2)
    sub = rospy.Subscriber('ar_pose_marker', AlvarMarkers, xy_callback, pub)
    rospy.init_node('teleop_xy_hector')
    rospy.spin()