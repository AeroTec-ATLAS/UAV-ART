; Auto-generated. Do not edit!


(cl:in-package mavros_msgs-msg)


;//! \htmlinclude NavControllerOutput.msg.html

(cl:defclass <NavControllerOutput> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (nav_roll
    :reader nav_roll
    :initarg :nav_roll
    :type cl:float
    :initform 0.0)
   (nav_pitch
    :reader nav_pitch
    :initarg :nav_pitch
    :type cl:float
    :initform 0.0)
   (nav_bearing
    :reader nav_bearing
    :initarg :nav_bearing
    :type cl:fixnum
    :initform 0)
   (target_bearing
    :reader target_bearing
    :initarg :target_bearing
    :type cl:fixnum
    :initform 0)
   (wp_dist
    :reader wp_dist
    :initarg :wp_dist
    :type cl:fixnum
    :initform 0)
   (alt_error
    :reader alt_error
    :initarg :alt_error
    :type cl:float
    :initform 0.0)
   (aspd_error
    :reader aspd_error
    :initarg :aspd_error
    :type cl:float
    :initform 0.0)
   (xtrack_error
    :reader xtrack_error
    :initarg :xtrack_error
    :type cl:float
    :initform 0.0))
)

(cl:defclass NavControllerOutput (<NavControllerOutput>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NavControllerOutput>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NavControllerOutput)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mavros_msgs-msg:<NavControllerOutput> is deprecated: use mavros_msgs-msg:NavControllerOutput instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <NavControllerOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:header-val is deprecated.  Use mavros_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'nav_roll-val :lambda-list '(m))
(cl:defmethod nav_roll-val ((m <NavControllerOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:nav_roll-val is deprecated.  Use mavros_msgs-msg:nav_roll instead.")
  (nav_roll m))

(cl:ensure-generic-function 'nav_pitch-val :lambda-list '(m))
(cl:defmethod nav_pitch-val ((m <NavControllerOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:nav_pitch-val is deprecated.  Use mavros_msgs-msg:nav_pitch instead.")
  (nav_pitch m))

(cl:ensure-generic-function 'nav_bearing-val :lambda-list '(m))
(cl:defmethod nav_bearing-val ((m <NavControllerOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:nav_bearing-val is deprecated.  Use mavros_msgs-msg:nav_bearing instead.")
  (nav_bearing m))

(cl:ensure-generic-function 'target_bearing-val :lambda-list '(m))
(cl:defmethod target_bearing-val ((m <NavControllerOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:target_bearing-val is deprecated.  Use mavros_msgs-msg:target_bearing instead.")
  (target_bearing m))

(cl:ensure-generic-function 'wp_dist-val :lambda-list '(m))
(cl:defmethod wp_dist-val ((m <NavControllerOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:wp_dist-val is deprecated.  Use mavros_msgs-msg:wp_dist instead.")
  (wp_dist m))

(cl:ensure-generic-function 'alt_error-val :lambda-list '(m))
(cl:defmethod alt_error-val ((m <NavControllerOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:alt_error-val is deprecated.  Use mavros_msgs-msg:alt_error instead.")
  (alt_error m))

(cl:ensure-generic-function 'aspd_error-val :lambda-list '(m))
(cl:defmethod aspd_error-val ((m <NavControllerOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:aspd_error-val is deprecated.  Use mavros_msgs-msg:aspd_error instead.")
  (aspd_error m))

(cl:ensure-generic-function 'xtrack_error-val :lambda-list '(m))
(cl:defmethod xtrack_error-val ((m <NavControllerOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:xtrack_error-val is deprecated.  Use mavros_msgs-msg:xtrack_error instead.")
  (xtrack_error m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NavControllerOutput>) ostream)
  "Serializes a message object of type '<NavControllerOutput>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'nav_roll))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'nav_pitch))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'nav_bearing)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'target_bearing)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'wp_dist)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'wp_dist)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'alt_error))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aspd_error))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'xtrack_error))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NavControllerOutput>) istream)
  "Deserializes a message object of type '<NavControllerOutput>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'nav_roll) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'nav_pitch) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nav_bearing) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'target_bearing) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'wp_dist)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'wp_dist)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'alt_error) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aspd_error) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'xtrack_error) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NavControllerOutput>)))
  "Returns string type for a message object of type '<NavControllerOutput>"
  "mavros_msgs/NavControllerOutput")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavControllerOutput)))
  "Returns string type for a message object of type 'NavControllerOutput"
  "mavros_msgs/NavControllerOutput")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NavControllerOutput>)))
  "Returns md5sum for a message object of type '<NavControllerOutput>"
  "f6340c9bb79e3ac2a6142ce592e66756")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NavControllerOutput)))
  "Returns md5sum for a message object of type 'NavControllerOutput"
  "f6340c9bb79e3ac2a6142ce592e66756")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NavControllerOutput>)))
  "Returns full string definition for message of type '<NavControllerOutput>"
  (cl:format cl:nil "# https://mavlink.io/en/messages/common.html#NAV_CONTROLLER_OUTPUT~%~%std_msgs/Header header~%~%float32 nav_roll            # Current desired roll~%float32 nav_pitch           # Current desired pitch~%int16 nav_bearing           # Current desired heading~%int16 target_bearing        # Bearing to current waypoint/target~%uint16 wp_dist              # Distance to active waypoint~%float32 alt_error           # Current altitude error~%float32 aspd_error          # Current airspeed error~%float32 xtrack_error        # Current crosstrack error on x-y plane~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NavControllerOutput)))
  "Returns full string definition for message of type 'NavControllerOutput"
  (cl:format cl:nil "# https://mavlink.io/en/messages/common.html#NAV_CONTROLLER_OUTPUT~%~%std_msgs/Header header~%~%float32 nav_roll            # Current desired roll~%float32 nav_pitch           # Current desired pitch~%int16 nav_bearing           # Current desired heading~%int16 target_bearing        # Bearing to current waypoint/target~%uint16 wp_dist              # Distance to active waypoint~%float32 alt_error           # Current altitude error~%float32 aspd_error          # Current airspeed error~%float32 xtrack_error        # Current crosstrack error on x-y plane~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NavControllerOutput>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     2
     2
     2
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NavControllerOutput>))
  "Converts a ROS message object to a list"
  (cl:list 'NavControllerOutput
    (cl:cons ':header (header msg))
    (cl:cons ':nav_roll (nav_roll msg))
    (cl:cons ':nav_pitch (nav_pitch msg))
    (cl:cons ':nav_bearing (nav_bearing msg))
    (cl:cons ':target_bearing (target_bearing msg))
    (cl:cons ':wp_dist (wp_dist msg))
    (cl:cons ':alt_error (alt_error msg))
    (cl:cons ':aspd_error (aspd_error msg))
    (cl:cons ':xtrack_error (xtrack_error msg))
))
