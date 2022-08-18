;; Auto-generated. Do not edit!


(when (boundp 'mavros_msgs::TerrainReport)
  (if (not (find-package "MAVROS_MSGS"))
    (make-package "MAVROS_MSGS"))
  (shadow 'TerrainReport (find-package "MAVROS_MSGS")))
(unless (find-package "MAVROS_MSGS::TERRAINREPORT")
  (make-package "MAVROS_MSGS::TERRAINREPORT"))

(in-package "ROS")
;;//! \htmlinclude TerrainReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass mavros_msgs::TerrainReport
  :super ros::object
  :slots (_header _latitude _longitude _spacing _terrain_height _current_height _pending _loaded ))

(defmethod mavros_msgs::TerrainReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:latitude __latitude) 0.0)
    ((:longitude __longitude) 0.0)
    ((:spacing __spacing) 0)
    ((:terrain_height __terrain_height) 0.0)
    ((:current_height __current_height) 0.0)
    ((:pending __pending) 0)
    ((:loaded __loaded) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _latitude (float __latitude))
   (setq _longitude (float __longitude))
   (setq _spacing (round __spacing))
   (setq _terrain_height (float __terrain_height))
   (setq _current_height (float __current_height))
   (setq _pending (round __pending))
   (setq _loaded (round __loaded))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:latitude
   (&optional __latitude)
   (if __latitude (setq _latitude __latitude)) _latitude)
  (:longitude
   (&optional __longitude)
   (if __longitude (setq _longitude __longitude)) _longitude)
  (:spacing
   (&optional __spacing)
   (if __spacing (setq _spacing __spacing)) _spacing)
  (:terrain_height
   (&optional __terrain_height)
   (if __terrain_height (setq _terrain_height __terrain_height)) _terrain_height)
  (:current_height
   (&optional __current_height)
   (if __current_height (setq _current_height __current_height)) _current_height)
  (:pending
   (&optional __pending)
   (if __pending (setq _pending __pending)) _pending)
  (:loaded
   (&optional __loaded)
   (if __loaded (setq _loaded __loaded)) _loaded)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float64 _latitude
    8
    ;; float64 _longitude
    8
    ;; uint16 _spacing
    2
    ;; float32 _terrain_height
    4
    ;; float32 _current_height
    4
    ;; uint16 _pending
    2
    ;; uint16 _loaded
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float64 _latitude
       (sys::poke _latitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _longitude
       (sys::poke _longitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; uint16 _spacing
       (write-word _spacing s)
     ;; float32 _terrain_height
       (sys::poke _terrain_height (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _current_height
       (sys::poke _current_height (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint16 _pending
       (write-word _pending s)
     ;; uint16 _loaded
       (write-word _loaded s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float64 _latitude
     (setq _latitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _longitude
     (setq _longitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; uint16 _spacing
     (setq _spacing (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; float32 _terrain_height
     (setq _terrain_height (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _current_height
     (setq _current_height (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint16 _pending
     (setq _pending (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _loaded
     (setq _loaded (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get mavros_msgs::TerrainReport :md5sum-) "f658be3a775aa38d678b427733ae0139")
(setf (get mavros_msgs::TerrainReport :datatype-) "mavros_msgs/TerrainReport")
(setf (get mavros_msgs::TerrainReport :definition-)
      "# Message for TERRAIN_REPORT
# https://mavlink.io/en/messages/common.html#TERRAIN_REPORT

std_msgs/Header header

float64 latitude
float64 longitude
uint16 spacing
float32 terrain_height # in meters, terrain height
float32 current_height # in meters, vehicle height above terrain
uint16 pending
uint16 loaded 

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



(provide :mavros_msgs/TerrainReport "f658be3a775aa38d678b427733ae0139")


