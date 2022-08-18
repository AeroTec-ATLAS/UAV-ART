; Auto-generated. Do not edit!


(cl:in-package mavros_msgs-msg)


;//! \htmlinclude TerrainReport.msg.html

(cl:defclass <TerrainReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (latitude
    :reader latitude
    :initarg :latitude
    :type cl:float
    :initform 0.0)
   (longitude
    :reader longitude
    :initarg :longitude
    :type cl:float
    :initform 0.0)
   (spacing
    :reader spacing
    :initarg :spacing
    :type cl:fixnum
    :initform 0)
   (terrain_height
    :reader terrain_height
    :initarg :terrain_height
    :type cl:float
    :initform 0.0)
   (current_height
    :reader current_height
    :initarg :current_height
    :type cl:float
    :initform 0.0)
   (pending
    :reader pending
    :initarg :pending
    :type cl:fixnum
    :initform 0)
   (loaded
    :reader loaded
    :initarg :loaded
    :type cl:fixnum
    :initform 0))
)

(cl:defclass TerrainReport (<TerrainReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TerrainReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TerrainReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mavros_msgs-msg:<TerrainReport> is deprecated: use mavros_msgs-msg:TerrainReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TerrainReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:header-val is deprecated.  Use mavros_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'latitude-val :lambda-list '(m))
(cl:defmethod latitude-val ((m <TerrainReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:latitude-val is deprecated.  Use mavros_msgs-msg:latitude instead.")
  (latitude m))

(cl:ensure-generic-function 'longitude-val :lambda-list '(m))
(cl:defmethod longitude-val ((m <TerrainReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:longitude-val is deprecated.  Use mavros_msgs-msg:longitude instead.")
  (longitude m))

(cl:ensure-generic-function 'spacing-val :lambda-list '(m))
(cl:defmethod spacing-val ((m <TerrainReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:spacing-val is deprecated.  Use mavros_msgs-msg:spacing instead.")
  (spacing m))

(cl:ensure-generic-function 'terrain_height-val :lambda-list '(m))
(cl:defmethod terrain_height-val ((m <TerrainReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:terrain_height-val is deprecated.  Use mavros_msgs-msg:terrain_height instead.")
  (terrain_height m))

(cl:ensure-generic-function 'current_height-val :lambda-list '(m))
(cl:defmethod current_height-val ((m <TerrainReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:current_height-val is deprecated.  Use mavros_msgs-msg:current_height instead.")
  (current_height m))

(cl:ensure-generic-function 'pending-val :lambda-list '(m))
(cl:defmethod pending-val ((m <TerrainReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:pending-val is deprecated.  Use mavros_msgs-msg:pending instead.")
  (pending m))

(cl:ensure-generic-function 'loaded-val :lambda-list '(m))
(cl:defmethod loaded-val ((m <TerrainReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:loaded-val is deprecated.  Use mavros_msgs-msg:loaded instead.")
  (loaded m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TerrainReport>) ostream)
  "Serializes a message object of type '<TerrainReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'latitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'longitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'spacing)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'spacing)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'terrain_height))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'current_height))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'pending)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'pending)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'loaded)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'loaded)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TerrainReport>) istream)
  "Deserializes a message object of type '<TerrainReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'latitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'longitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'spacing)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'spacing)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'terrain_height) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'current_height) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'pending)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'pending)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'loaded)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'loaded)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TerrainReport>)))
  "Returns string type for a message object of type '<TerrainReport>"
  "mavros_msgs/TerrainReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TerrainReport)))
  "Returns string type for a message object of type 'TerrainReport"
  "mavros_msgs/TerrainReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TerrainReport>)))
  "Returns md5sum for a message object of type '<TerrainReport>"
  "f658be3a775aa38d678b427733ae0139")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TerrainReport)))
  "Returns md5sum for a message object of type 'TerrainReport"
  "f658be3a775aa38d678b427733ae0139")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TerrainReport>)))
  "Returns full string definition for message of type '<TerrainReport>"
  (cl:format cl:nil "# Message for TERRAIN_REPORT~%# https://mavlink.io/en/messages/common.html#TERRAIN_REPORT~%~%std_msgs/Header header~%~%float64 latitude~%float64 longitude~%uint16 spacing~%float32 terrain_height # in meters, terrain height~%float32 current_height # in meters, vehicle height above terrain~%uint16 pending~%uint16 loaded ~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TerrainReport)))
  "Returns full string definition for message of type 'TerrainReport"
  (cl:format cl:nil "# Message for TERRAIN_REPORT~%# https://mavlink.io/en/messages/common.html#TERRAIN_REPORT~%~%std_msgs/Header header~%~%float64 latitude~%float64 longitude~%uint16 spacing~%float32 terrain_height # in meters, terrain height~%float32 current_height # in meters, vehicle height above terrain~%uint16 pending~%uint16 loaded ~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TerrainReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     8
     8
     2
     4
     4
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TerrainReport>))
  "Converts a ROS message object to a list"
  (cl:list 'TerrainReport
    (cl:cons ':header (header msg))
    (cl:cons ':latitude (latitude msg))
    (cl:cons ':longitude (longitude msg))
    (cl:cons ':spacing (spacing msg))
    (cl:cons ':terrain_height (terrain_height msg))
    (cl:cons ':current_height (current_height msg))
    (cl:cons ':pending (pending msg))
    (cl:cons ':loaded (loaded msg))
))
