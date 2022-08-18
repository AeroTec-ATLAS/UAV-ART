;; Auto-generated. Do not edit!


(when (boundp 'mavros_msgs::NavControllerOutput)
  (if (not (find-package "MAVROS_MSGS"))
    (make-package "MAVROS_MSGS"))
  (shadow 'NavControllerOutput (find-package "MAVROS_MSGS")))
(unless (find-package "MAVROS_MSGS::NAVCONTROLLEROUTPUT")
  (make-package "MAVROS_MSGS::NAVCONTROLLEROUTPUT"))

(in-package "ROS")
;;//! \htmlinclude NavControllerOutput.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass mavros_msgs::NavControllerOutput
  :super ros::object
  :slots (_header _nav_roll _nav_pitch _nav_bearing _target_bearing _wp_dist _alt_error _aspd_error _xtrack_error ))

(defmethod mavros_msgs::NavControllerOutput
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:nav_roll __nav_roll) 0.0)
    ((:nav_pitch __nav_pitch) 0.0)
    ((:nav_bearing __nav_bearing) 0)
    ((:target_bearing __target_bearing) 0)
    ((:wp_dist __wp_dist) 0)
    ((:alt_error __alt_error) 0.0)
    ((:aspd_error __aspd_error) 0.0)
    ((:xtrack_error __xtrack_error) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _nav_roll (float __nav_roll))
   (setq _nav_pitch (float __nav_pitch))
   (setq _nav_bearing (round __nav_bearing))
   (setq _target_bearing (round __target_bearing))
   (setq _wp_dist (round __wp_dist))
   (setq _alt_error (float __alt_error))
   (setq _aspd_error (float __aspd_error))
   (setq _xtrack_error (float __xtrack_error))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:nav_roll
   (&optional __nav_roll)
   (if __nav_roll (setq _nav_roll __nav_roll)) _nav_roll)
  (:nav_pitch
   (&optional __nav_pitch)
   (if __nav_pitch (setq _nav_pitch __nav_pitch)) _nav_pitch)
  (:nav_bearing
   (&optional __nav_bearing)
   (if __nav_bearing (setq _nav_bearing __nav_bearing)) _nav_bearing)
  (:target_bearing
   (&optional __target_bearing)
   (if __target_bearing (setq _target_bearing __target_bearing)) _target_bearing)
  (:wp_dist
   (&optional __wp_dist)
   (if __wp_dist (setq _wp_dist __wp_dist)) _wp_dist)
  (:alt_error
   (&optional __alt_error)
   (if __alt_error (setq _alt_error __alt_error)) _alt_error)
  (:aspd_error
   (&optional __aspd_error)
   (if __aspd_error (setq _aspd_error __aspd_error)) _aspd_error)
  (:xtrack_error
   (&optional __xtrack_error)
   (if __xtrack_error (setq _xtrack_error __xtrack_error)) _xtrack_error)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _nav_roll
    4
    ;; float32 _nav_pitch
    4
    ;; int16 _nav_bearing
    2
    ;; int16 _target_bearing
    2
    ;; uint16 _wp_dist
    2
    ;; float32 _alt_error
    4
    ;; float32 _aspd_error
    4
    ;; float32 _xtrack_error
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _nav_roll
       (sys::poke _nav_roll (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _nav_pitch
       (sys::poke _nav_pitch (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int16 _nav_bearing
       (write-word _nav_bearing s)
     ;; int16 _target_bearing
       (write-word _target_bearing s)
     ;; uint16 _wp_dist
       (write-word _wp_dist s)
     ;; float32 _alt_error
       (sys::poke _alt_error (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _aspd_error
       (sys::poke _aspd_error (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _xtrack_error
       (sys::poke _xtrack_error (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _nav_roll
     (setq _nav_roll (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _nav_pitch
     (setq _nav_pitch (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int16 _nav_bearing
     (setq _nav_bearing (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _target_bearing
     (setq _target_bearing (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _wp_dist
     (setq _wp_dist (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; float32 _alt_error
     (setq _alt_error (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _aspd_error
     (setq _aspd_error (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _xtrack_error
     (setq _xtrack_error (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get mavros_msgs::NavControllerOutput :md5sum-) "f6340c9bb79e3ac2a6142ce592e66756")
(setf (get mavros_msgs::NavControllerOutput :datatype-) "mavros_msgs/NavControllerOutput")
(setf (get mavros_msgs::NavControllerOutput :definition-)
      "# https://mavlink.io/en/messages/common.html#NAV_CONTROLLER_OUTPUT

std_msgs/Header header

float32 nav_roll            # Current desired roll
float32 nav_pitch           # Current desired pitch
int16 nav_bearing           # Current desired heading
int16 target_bearing        # Bearing to current waypoint/target
uint16 wp_dist              # Distance to active waypoint
float32 alt_error           # Current altitude error
float32 aspd_error          # Current airspeed error
float32 xtrack_error        # Current crosstrack error on x-y plane
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :mavros_msgs/NavControllerOutput "f6340c9bb79e3ac2a6142ce592e66756")


