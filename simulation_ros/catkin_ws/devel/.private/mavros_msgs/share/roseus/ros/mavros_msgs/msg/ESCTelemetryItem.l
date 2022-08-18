;; Auto-generated. Do not edit!


(when (boundp 'mavros_msgs::ESCTelemetryItem)
  (if (not (find-package "MAVROS_MSGS"))
    (make-package "MAVROS_MSGS"))
  (shadow 'ESCTelemetryItem (find-package "MAVROS_MSGS")))
(unless (find-package "MAVROS_MSGS::ESCTELEMETRYITEM")
  (make-package "MAVROS_MSGS::ESCTELEMETRYITEM"))

(in-package "ROS")
;;//! \htmlinclude ESCTelemetryItem.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass mavros_msgs::ESCTelemetryItem
  :super ros::object
  :slots (_header _temperature _voltage _current _totalcurrent _rpm _count ))

(defmethod mavros_msgs::ESCTelemetryItem
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:temperature __temperature) 0.0)
    ((:voltage __voltage) 0.0)
    ((:current __current) 0.0)
    ((:totalcurrent __totalcurrent) 0.0)
    ((:rpm __rpm) 0)
    ((:count __count) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _temperature (float __temperature))
   (setq _voltage (float __voltage))
   (setq _current (float __current))
   (setq _totalcurrent (float __totalcurrent))
   (setq _rpm (round __rpm))
   (setq _count (round __count))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:temperature
   (&optional __temperature)
   (if __temperature (setq _temperature __temperature)) _temperature)
  (:voltage
   (&optional __voltage)
   (if __voltage (setq _voltage __voltage)) _voltage)
  (:current
   (&optional __current)
   (if __current (setq _current __current)) _current)
  (:totalcurrent
   (&optional __totalcurrent)
   (if __totalcurrent (setq _totalcurrent __totalcurrent)) _totalcurrent)
  (:rpm
   (&optional __rpm)
   (if __rpm (setq _rpm __rpm)) _rpm)
  (:count
   (&optional __count)
   (if __count (setq _count __count)) _count)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _temperature
    4
    ;; float32 _voltage
    4
    ;; float32 _current
    4
    ;; float32 _totalcurrent
    4
    ;; int32 _rpm
    4
    ;; uint16 _count
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _temperature
       (sys::poke _temperature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _voltage
       (sys::poke _voltage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _current
       (sys::poke _current (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _totalcurrent
       (sys::poke _totalcurrent (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _rpm
       (write-long _rpm s)
     ;; uint16 _count
       (write-word _count s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _temperature
     (setq _temperature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _voltage
     (setq _voltage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _current
     (setq _current (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _totalcurrent
     (setq _totalcurrent (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _rpm
     (setq _rpm (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint16 _count
     (setq _count (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get mavros_msgs::ESCTelemetryItem :md5sum-) "a135c5d0c71a3bade75476291a42a6df")
(setf (get mavros_msgs::ESCTelemetryItem :datatype-) "mavros_msgs/ESCTelemetryItem")
(setf (get mavros_msgs::ESCTelemetryItem :definition-)
      "# APM ESC Telemetry as returned by BLHeli
#
# See:
# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_1_TO_4
# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_5_TO_8
# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_9_TO_12

std_msgs/Header header

float32 temperature     # deg C
float32 voltage         # V
float32 current         # A
float32 totalcurrent    # Ah
int32 rpm               # -1/min
uint16 count            # count of telemetry packets

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



(provide :mavros_msgs/ESCTelemetryItem "a135c5d0c71a3bade75476291a42a6df")


