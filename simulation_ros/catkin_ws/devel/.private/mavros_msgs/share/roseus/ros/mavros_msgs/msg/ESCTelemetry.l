;; Auto-generated. Do not edit!


(when (boundp 'mavros_msgs::ESCTelemetry)
  (if (not (find-package "MAVROS_MSGS"))
    (make-package "MAVROS_MSGS"))
  (shadow 'ESCTelemetry (find-package "MAVROS_MSGS")))
(unless (find-package "MAVROS_MSGS::ESCTELEMETRY")
  (make-package "MAVROS_MSGS::ESCTELEMETRY"))

(in-package "ROS")
;;//! \htmlinclude ESCTelemetry.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass mavros_msgs::ESCTelemetry
  :super ros::object
  :slots (_header _esc_telemetry ))

(defmethod mavros_msgs::ESCTelemetry
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:esc_telemetry __esc_telemetry) (let (r) (dotimes (i 0) (push (instance mavros_msgs::ESCTelemetryItem :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _esc_telemetry __esc_telemetry)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:esc_telemetry
   (&rest __esc_telemetry)
   (if (keywordp (car __esc_telemetry))
       (send* _esc_telemetry __esc_telemetry)
     (progn
       (if __esc_telemetry (setq _esc_telemetry (car __esc_telemetry)))
       _esc_telemetry)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; mavros_msgs/ESCTelemetryItem[] _esc_telemetry
    (apply #'+ (send-all _esc_telemetry :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; mavros_msgs/ESCTelemetryItem[] _esc_telemetry
     (write-long (length _esc_telemetry) s)
     (dolist (elem _esc_telemetry)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; mavros_msgs/ESCTelemetryItem[] _esc_telemetry
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _esc_telemetry (let (r) (dotimes (i n) (push (instance mavros_msgs::ESCTelemetryItem :init) r)) r))
     (dolist (elem- _esc_telemetry)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get mavros_msgs::ESCTelemetry :md5sum-) "7b1fb252ca6aa175fe8dd23d029b3362")
(setf (get mavros_msgs::ESCTelemetry :datatype-) "mavros_msgs/ESCTelemetry")
(setf (get mavros_msgs::ESCTelemetry :definition-)
      "# APM ESC Telemetry as returned by BLHeli
#
# See:
# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_1_TO_4
# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_5_TO_8
# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_9_TO_12

std_msgs/Header header

mavros_msgs/ESCTelemetryItem[] esc_telemetry

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

================================================================================
MSG: mavros_msgs/ESCTelemetryItem
# APM ESC Telemetry as returned by BLHeli
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

")



(provide :mavros_msgs/ESCTelemetry "7b1fb252ca6aa175fe8dd23d029b3362")


