;; Auto-generated. Do not edit!


(when (boundp 'mavros_msgs::CameraImageCaptured)
  (if (not (find-package "MAVROS_MSGS"))
    (make-package "MAVROS_MSGS"))
  (shadow 'CameraImageCaptured (find-package "MAVROS_MSGS")))
(unless (find-package "MAVROS_MSGS::CAMERAIMAGECAPTURED")
  (make-package "MAVROS_MSGS::CAMERAIMAGECAPTURED"))

(in-package "ROS")
;;//! \htmlinclude CameraImageCaptured.msg.html
(if (not (find-package "GEOGRAPHIC_MSGS"))
  (ros::roseus-add-msgs "geographic_msgs"))
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass mavros_msgs::CameraImageCaptured
  :super ros::object
  :slots (_header _orientation _geo _relative_alt _image_index _capture_result _file_url ))

(defmethod mavros_msgs::CameraImageCaptured
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:orientation __orientation) (instance geometry_msgs::Quaternion :init))
    ((:geo __geo) (instance geographic_msgs::GeoPoint :init))
    ((:relative_alt __relative_alt) 0.0)
    ((:image_index __image_index) 0)
    ((:capture_result __capture_result) 0)
    ((:file_url __file_url) "")
    )
   (send-super :init)
   (setq _header __header)
   (setq _orientation __orientation)
   (setq _geo __geo)
   (setq _relative_alt (float __relative_alt))
   (setq _image_index (round __image_index))
   (setq _capture_result (round __capture_result))
   (setq _file_url (string __file_url))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:orientation
   (&rest __orientation)
   (if (keywordp (car __orientation))
       (send* _orientation __orientation)
     (progn
       (if __orientation (setq _orientation (car __orientation)))
       _orientation)))
  (:geo
   (&rest __geo)
   (if (keywordp (car __geo))
       (send* _geo __geo)
     (progn
       (if __geo (setq _geo (car __geo)))
       _geo)))
  (:relative_alt
   (&optional __relative_alt)
   (if __relative_alt (setq _relative_alt __relative_alt)) _relative_alt)
  (:image_index
   (&optional __image_index)
   (if __image_index (setq _image_index __image_index)) _image_index)
  (:capture_result
   (&optional __capture_result)
   (if __capture_result (setq _capture_result __capture_result)) _capture_result)
  (:file_url
   (&optional __file_url)
   (if __file_url (setq _file_url __file_url)) _file_url)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Quaternion _orientation
    (send _orientation :serialization-length)
    ;; geographic_msgs/GeoPoint _geo
    (send _geo :serialization-length)
    ;; float32 _relative_alt
    4
    ;; int32 _image_index
    4
    ;; int8 _capture_result
    1
    ;; string _file_url
    4 (length _file_url)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/Quaternion _orientation
       (send _orientation :serialize s)
     ;; geographic_msgs/GeoPoint _geo
       (send _geo :serialize s)
     ;; float32 _relative_alt
       (sys::poke _relative_alt (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _image_index
       (write-long _image_index s)
     ;; int8 _capture_result
       (write-byte _capture_result s)
     ;; string _file_url
       (write-long (length _file_url) s) (princ _file_url s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/Quaternion _orientation
     (send _orientation :deserialize buf ptr-) (incf ptr- (send _orientation :serialization-length))
   ;; geographic_msgs/GeoPoint _geo
     (send _geo :deserialize buf ptr-) (incf ptr- (send _geo :serialization-length))
   ;; float32 _relative_alt
     (setq _relative_alt (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _image_index
     (setq _image_index (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int8 _capture_result
     (setq _capture_result (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _capture_result 127) (setq _capture_result (- _capture_result 256)))
   ;; string _file_url
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _file_url (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get mavros_msgs::CameraImageCaptured :md5sum-) "9559d135fc7e5e91d3f1b819ebcd7556")
(setf (get mavros_msgs::CameraImageCaptured :datatype-) "mavros_msgs/CameraImageCaptured")
(setf (get mavros_msgs::CameraImageCaptured :definition-)
      "# MAVLink message: CAMERA_IMAGE_CAPTURED
# https://mavlink.io/en/messages/common.html#CAMERA_IMAGE_CAPTURED

std_msgs/Header header

geometry_msgs/Quaternion orientation	# Quaternion of camera orientation (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
geographic_msgs/GeoPoint geo
float32 relative_alt	# mm	Altitude above ground
int32 image_index # Zero based index of this image (i.e. a new image will have index CAMERA_CAPTURE_STATUS.image count -1)
int8 capture_result # Boolean indicating success (1) or failure (0) while capturing this image.
string file_url #URL of image taken. Either local storage or http://foo.jpg if camera provides an HTTP interface.

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
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geographic_msgs/GeoPoint
# Geographic point, using the WGS 84 reference ellipsoid.

# Latitude [degrees]. Positive is north of equator; negative is south
# (-90 <= latitude <= +90).
float64 latitude

# Longitude [degrees]. Positive is east of prime meridian; negative is
# west (-180 <= longitude <= +180). At the poles, latitude is -90 or
# +90, and longitude is irrelevant, but must be in range.
float64 longitude

# Altitude [m]. Positive is above the WGS 84 ellipsoid (NaN if unspecified).
float64 altitude

")



(provide :mavros_msgs/CameraImageCaptured "9559d135fc7e5e91d3f1b819ebcd7556")


