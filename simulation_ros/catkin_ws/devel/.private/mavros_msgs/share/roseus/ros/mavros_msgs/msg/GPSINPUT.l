;; Auto-generated. Do not edit!


(when (boundp 'mavros_msgs::GPSINPUT)
  (if (not (find-package "MAVROS_MSGS"))
    (make-package "MAVROS_MSGS"))
  (shadow 'GPSINPUT (find-package "MAVROS_MSGS")))
(unless (find-package "MAVROS_MSGS::GPSINPUT")
  (make-package "MAVROS_MSGS::GPSINPUT"))

(in-package "ROS")
;;//! \htmlinclude GPSINPUT.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*GPS_FIX_TYPE_NO_GPS*" (find-package "MAVROS_MSGS::GPSINPUT"))
(shadow '*GPS_FIX_TYPE_NO_GPS* (find-package "MAVROS_MSGS::GPSINPUT"))
(defconstant mavros_msgs::GPSINPUT::*GPS_FIX_TYPE_NO_GPS* 0)
(intern "*GPS_FIX_TYPE_NO_FIX*" (find-package "MAVROS_MSGS::GPSINPUT"))
(shadow '*GPS_FIX_TYPE_NO_FIX* (find-package "MAVROS_MSGS::GPSINPUT"))
(defconstant mavros_msgs::GPSINPUT::*GPS_FIX_TYPE_NO_FIX* 1)
(intern "*GPS_FIX_TYPE_2D_FIX*" (find-package "MAVROS_MSGS::GPSINPUT"))
(shadow '*GPS_FIX_TYPE_2D_FIX* (find-package "MAVROS_MSGS::GPSINPUT"))
(defconstant mavros_msgs::GPSINPUT::*GPS_FIX_TYPE_2D_FIX* 2)
(intern "*GPS_FIX_TYPE_3D_FIX*" (find-package "MAVROS_MSGS::GPSINPUT"))
(shadow '*GPS_FIX_TYPE_3D_FIX* (find-package "MAVROS_MSGS::GPSINPUT"))
(defconstant mavros_msgs::GPSINPUT::*GPS_FIX_TYPE_3D_FIX* 3)
(intern "*GPS_FIX_TYPE_DGPS*" (find-package "MAVROS_MSGS::GPSINPUT"))
(shadow '*GPS_FIX_TYPE_DGPS* (find-package "MAVROS_MSGS::GPSINPUT"))
(defconstant mavros_msgs::GPSINPUT::*GPS_FIX_TYPE_DGPS* 4)
(intern "*GPS_FIX_TYPE_RTK_FLOATR*" (find-package "MAVROS_MSGS::GPSINPUT"))
(shadow '*GPS_FIX_TYPE_RTK_FLOATR* (find-package "MAVROS_MSGS::GPSINPUT"))
(defconstant mavros_msgs::GPSINPUT::*GPS_FIX_TYPE_RTK_FLOATR* 5)
(intern "*GPS_FIX_TYPE_RTK_FIXEDR*" (find-package "MAVROS_MSGS::GPSINPUT"))
(shadow '*GPS_FIX_TYPE_RTK_FIXEDR* (find-package "MAVROS_MSGS::GPSINPUT"))
(defconstant mavros_msgs::GPSINPUT::*GPS_FIX_TYPE_RTK_FIXEDR* 6)
(intern "*GPS_FIX_TYPE_STATIC*" (find-package "MAVROS_MSGS::GPSINPUT"))
(shadow '*GPS_FIX_TYPE_STATIC* (find-package "MAVROS_MSGS::GPSINPUT"))
(defconstant mavros_msgs::GPSINPUT::*GPS_FIX_TYPE_STATIC* 7)
(intern "*GPS_FIX_TYPE_PPP*" (find-package "MAVROS_MSGS::GPSINPUT"))
(shadow '*GPS_FIX_TYPE_PPP* (find-package "MAVROS_MSGS::GPSINPUT"))
(defconstant mavros_msgs::GPSINPUT::*GPS_FIX_TYPE_PPP* 8)
(defclass mavros_msgs::GPSINPUT
  :super ros::object
  :slots (_header _fix_type _gps_id _ignore_flags _time_week_ms _time_week _lat _lon _alt _hdop _vdop _vn _ve _vd _speed_accuracy _horiz_accuracy _vert_accuracy _satellites_visible _yaw ))

(defmethod mavros_msgs::GPSINPUT
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:fix_type __fix_type) 0)
    ((:gps_id __gps_id) 0)
    ((:ignore_flags __ignore_flags) 0)
    ((:time_week_ms __time_week_ms) 0)
    ((:time_week __time_week) 0)
    ((:lat __lat) 0)
    ((:lon __lon) 0)
    ((:alt __alt) 0.0)
    ((:hdop __hdop) 0.0)
    ((:vdop __vdop) 0.0)
    ((:vn __vn) 0.0)
    ((:ve __ve) 0.0)
    ((:vd __vd) 0.0)
    ((:speed_accuracy __speed_accuracy) 0.0)
    ((:horiz_accuracy __horiz_accuracy) 0.0)
    ((:vert_accuracy __vert_accuracy) 0.0)
    ((:satellites_visible __satellites_visible) 0)
    ((:yaw __yaw) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _fix_type (round __fix_type))
   (setq _gps_id (round __gps_id))
   (setq _ignore_flags (round __ignore_flags))
   (setq _time_week_ms (round __time_week_ms))
   (setq _time_week (round __time_week))
   (setq _lat (round __lat))
   (setq _lon (round __lon))
   (setq _alt (float __alt))
   (setq _hdop (float __hdop))
   (setq _vdop (float __vdop))
   (setq _vn (float __vn))
   (setq _ve (float __ve))
   (setq _vd (float __vd))
   (setq _speed_accuracy (float __speed_accuracy))
   (setq _horiz_accuracy (float __horiz_accuracy))
   (setq _vert_accuracy (float __vert_accuracy))
   (setq _satellites_visible (round __satellites_visible))
   (setq _yaw (round __yaw))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:fix_type
   (&optional __fix_type)
   (if __fix_type (setq _fix_type __fix_type)) _fix_type)
  (:gps_id
   (&optional __gps_id)
   (if __gps_id (setq _gps_id __gps_id)) _gps_id)
  (:ignore_flags
   (&optional __ignore_flags)
   (if __ignore_flags (setq _ignore_flags __ignore_flags)) _ignore_flags)
  (:time_week_ms
   (&optional __time_week_ms)
   (if __time_week_ms (setq _time_week_ms __time_week_ms)) _time_week_ms)
  (:time_week
   (&optional __time_week)
   (if __time_week (setq _time_week __time_week)) _time_week)
  (:lat
   (&optional __lat)
   (if __lat (setq _lat __lat)) _lat)
  (:lon
   (&optional __lon)
   (if __lon (setq _lon __lon)) _lon)
  (:alt
   (&optional __alt)
   (if __alt (setq _alt __alt)) _alt)
  (:hdop
   (&optional __hdop)
   (if __hdop (setq _hdop __hdop)) _hdop)
  (:vdop
   (&optional __vdop)
   (if __vdop (setq _vdop __vdop)) _vdop)
  (:vn
   (&optional __vn)
   (if __vn (setq _vn __vn)) _vn)
  (:ve
   (&optional __ve)
   (if __ve (setq _ve __ve)) _ve)
  (:vd
   (&optional __vd)
   (if __vd (setq _vd __vd)) _vd)
  (:speed_accuracy
   (&optional __speed_accuracy)
   (if __speed_accuracy (setq _speed_accuracy __speed_accuracy)) _speed_accuracy)
  (:horiz_accuracy
   (&optional __horiz_accuracy)
   (if __horiz_accuracy (setq _horiz_accuracy __horiz_accuracy)) _horiz_accuracy)
  (:vert_accuracy
   (&optional __vert_accuracy)
   (if __vert_accuracy (setq _vert_accuracy __vert_accuracy)) _vert_accuracy)
  (:satellites_visible
   (&optional __satellites_visible)
   (if __satellites_visible (setq _satellites_visible __satellites_visible)) _satellites_visible)
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _fix_type
    1
    ;; uint8 _gps_id
    1
    ;; uint16 _ignore_flags
    2
    ;; uint32 _time_week_ms
    4
    ;; uint16 _time_week
    2
    ;; int32 _lat
    4
    ;; int32 _lon
    4
    ;; float32 _alt
    4
    ;; float32 _hdop
    4
    ;; float32 _vdop
    4
    ;; float32 _vn
    4
    ;; float32 _ve
    4
    ;; float32 _vd
    4
    ;; float32 _speed_accuracy
    4
    ;; float32 _horiz_accuracy
    4
    ;; float32 _vert_accuracy
    4
    ;; uint8 _satellites_visible
    1
    ;; uint16 _yaw
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _fix_type
       (write-byte _fix_type s)
     ;; uint8 _gps_id
       (write-byte _gps_id s)
     ;; uint16 _ignore_flags
       (write-word _ignore_flags s)
     ;; uint32 _time_week_ms
       (write-long _time_week_ms s)
     ;; uint16 _time_week
       (write-word _time_week s)
     ;; int32 _lat
       (write-long _lat s)
     ;; int32 _lon
       (write-long _lon s)
     ;; float32 _alt
       (sys::poke _alt (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _hdop
       (sys::poke _hdop (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vdop
       (sys::poke _vdop (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vn
       (sys::poke _vn (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _ve
       (sys::poke _ve (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vd
       (sys::poke _vd (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _speed_accuracy
       (sys::poke _speed_accuracy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _horiz_accuracy
       (sys::poke _horiz_accuracy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vert_accuracy
       (sys::poke _vert_accuracy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _satellites_visible
       (write-byte _satellites_visible s)
     ;; uint16 _yaw
       (write-word _yaw s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _fix_type
     (setq _fix_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _gps_id
     (setq _gps_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint16 _ignore_flags
     (setq _ignore_flags (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint32 _time_week_ms
     (setq _time_week_ms (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint16 _time_week
     (setq _time_week (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int32 _lat
     (setq _lat (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _lon
     (setq _lon (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _alt
     (setq _alt (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _hdop
     (setq _hdop (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vdop
     (setq _vdop (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vn
     (setq _vn (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ve
     (setq _ve (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vd
     (setq _vd (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _speed_accuracy
     (setq _speed_accuracy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _horiz_accuracy
     (setq _horiz_accuracy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vert_accuracy
     (setq _vert_accuracy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _satellites_visible
     (setq _satellites_visible (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint16 _yaw
     (setq _yaw (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get mavros_msgs::GPSINPUT :md5sum-) "928ef4ffec7b9af7c6e4748f0542b6a0")
(setf (get mavros_msgs::GPSINPUT :datatype-) "mavros_msgs/GPSINPUT")
(setf (get mavros_msgs::GPSINPUT :definition-)
      "# FCU GPS INPUT message for the gps_input plugin
# <a href=\"https://mavlink.io/en/messages/common.html#GPS_INPUT\">mavlink GPS_INPUT message</a>.

std_msgs/Header header
## GPS_FIX_TYPE enum
uint8 GPS_FIX_TYPE_NO_GPS     = 0    # No GPS connected
uint8 GPS_FIX_TYPE_NO_FIX     = 1    # No position information, GPS is connected
uint8 GPS_FIX_TYPE_2D_FIX     = 2    # 2D position
uint8 GPS_FIX_TYPE_3D_FIX     = 3    # 3D position
uint8 GPS_FIX_TYPE_DGPS       = 4    # DGPS/SBAS aided 3D position
uint8 GPS_FIX_TYPE_RTK_FLOATR = 5    # TK float, 3D position
uint8 GPS_FIX_TYPE_RTK_FIXEDR = 6    # TK Fixed, 3D position
uint8 GPS_FIX_TYPE_STATIC     = 7    # Static fixed, typically used for base stations
uint8 GPS_FIX_TYPE_PPP        = 8    # PPP, 3D position
uint8 fix_type      # [GPS_FIX_TYPE] GPS fix type

uint8 gps_id        # ID of the GPS for multiple GPS inputs
uint16 ignore_flags # Bitmap indicating which GPS input flags fields to ignore. All other fields must be provided.

uint32 time_week_ms # [ms] GPS time (from start of GPS week)
uint16 time_week    # GPS week number
int32 lat           # [degE7] Latitude (WGS84, EGM96 ellipsoid)
int32 lon           # [degE7] Longitude (WGS84, EGM96 ellipsoid)
float32 alt         # [m] Altitude (MSL). Positive for up.

float32 hdop        # [m] GPS HDOP horizontal dilution of position.
float32 vdop        # [m] GPS VDOP vertical dilution of position
float32 vn          # [m/s] GPS velocity in NORTH direction in earth-fixed NED frame
float32 ve          # [m/s] GPS velocity in EAST direction in earth-fixed NED frame
float32 vd          # [m/s] GPS velocity in DOWN direction in earth-fixed NED frame

float32 speed_accuracy # [m/s] GPS speed accuracy
float32 horiz_accuracy # [m] GPS horizontal accuracy
float32 vert_accuracy  # [m] GPS vertical accuracy

uint8 satellites_visible # Number of satellites visible. If unknown, set to 255
uint16 yaw          # [cdeg] Yaw in earth frame from north.

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



(provide :mavros_msgs/GPSINPUT "928ef4ffec7b9af7c6e4748f0542b6a0")


