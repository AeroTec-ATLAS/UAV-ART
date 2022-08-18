;; Auto-generated. Do not edit!


(when (boundp 'mavros_msgs::WaypointList)
  (if (not (find-package "MAVROS_MSGS"))
    (make-package "MAVROS_MSGS"))
  (shadow 'WaypointList (find-package "MAVROS_MSGS")))
(unless (find-package "MAVROS_MSGS::WAYPOINTLIST")
  (make-package "MAVROS_MSGS::WAYPOINTLIST"))

(in-package "ROS")
;;//! \htmlinclude WaypointList.msg.html


(defclass mavros_msgs::WaypointList
  :super ros::object
  :slots (_current_seq _waypoints ))

(defmethod mavros_msgs::WaypointList
  (:init
   (&key
    ((:current_seq __current_seq) 0)
    ((:waypoints __waypoints) (let (r) (dotimes (i 0) (push (instance mavros_msgs::Waypoint :init) r)) r))
    )
   (send-super :init)
   (setq _current_seq (round __current_seq))
   (setq _waypoints __waypoints)
   self)
  (:current_seq
   (&optional __current_seq)
   (if __current_seq (setq _current_seq __current_seq)) _current_seq)
  (:waypoints
   (&rest __waypoints)
   (if (keywordp (car __waypoints))
       (send* _waypoints __waypoints)
     (progn
       (if __waypoints (setq _waypoints (car __waypoints)))
       _waypoints)))
  (:serialization-length
   ()
   (+
    ;; uint16 _current_seq
    2
    ;; mavros_msgs/Waypoint[] _waypoints
    (apply #'+ (send-all _waypoints :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16 _current_seq
       (write-word _current_seq s)
     ;; mavros_msgs/Waypoint[] _waypoints
     (write-long (length _waypoints) s)
     (dolist (elem _waypoints)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16 _current_seq
     (setq _current_seq (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; mavros_msgs/Waypoint[] _waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoints (let (r) (dotimes (i n) (push (instance mavros_msgs::Waypoint :init) r)) r))
     (dolist (elem- _waypoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get mavros_msgs::WaypointList :md5sum-) "0605a2df153acd9a4a4823385ed81b57")
(setf (get mavros_msgs::WaypointList :datatype-) "mavros_msgs/WaypointList")
(setf (get mavros_msgs::WaypointList :definition-)
      "# WaypointList.msg
#
#  :current_seq:   seq nr of currently active waypoint
#                  waypoints[current_seq].is_current == True
#
#  :waypoints:     list of waypoints

uint16 current_seq
mavros_msgs/Waypoint[] waypoints

================================================================================
MSG: mavros_msgs/Waypoint
# Waypoint.msg
#
# ROS representation of MAVLink MISSION_ITEM
# See mavlink documentation



# see enum MAV_FRAME
uint8 frame
uint8 FRAME_GLOBAL = 0
uint8 FRAME_LOCAL_NED = 1
uint8 FRAME_MISSION = 2
uint8 FRAME_GLOBAL_REL_ALT = 3
uint8 FRAME_LOCAL_ENU = 4
uint8 FRAME_GLOBAL_INT = 5
uint8 FRAME_GLOBAL_RELATIVE_ALT_INT = 6
uint8 FRAME_LOCAL_OFFSET_NED = 7
uint8 FRAME_BODY_NED = 8
uint8 FRAME_BODY_OFFSET_NED = 9
uint8 FRAME_GLOBAL_TERRAIN_ALT = 10
uint8 FRAME_GLOBAL_TERRAIN_ALT_INT = 11
uint8 FRAME_BODY_FRD = 12
uint8 FRAME_RESERVED_13 = 13
uint8 FRAME_RESERVED_14 = 14
uint8 FRAME_RESERVED_15 = 15
uint8 FRAME_RESERVED_16 = 16
uint8 FRAME_RESERVED_17 = 17
uint8 FRAME_RESERVED_18 = 18
uint8 FRAME_RESERVED_19 = 19
uint8 FRAME_LOCAL_FRD = 20
uint8 FRAME_LOCAL_FLU = 21

# see enum MAV_CMD and CommandCode.msg
uint16 command

bool is_current
bool autocontinue
# meaning of this params described in enum MAV_CMD
float32 param1
float32 param2
float32 param3
float32 param4
float64 x_lat
float64 y_long
float64 z_alt

")



(provide :mavros_msgs/WaypointList "0605a2df153acd9a4a4823385ed81b57")


