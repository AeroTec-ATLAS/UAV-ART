; Auto-generated. Do not edit!


(cl:in-package mavros_msgs-msg)


;//! \htmlinclude ESCTelemetryItem.msg.html

(cl:defclass <ESCTelemetryItem> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (temperature
    :reader temperature
    :initarg :temperature
    :type cl:float
    :initform 0.0)
   (voltage
    :reader voltage
    :initarg :voltage
    :type cl:float
    :initform 0.0)
   (current
    :reader current
    :initarg :current
    :type cl:float
    :initform 0.0)
   (totalcurrent
    :reader totalcurrent
    :initarg :totalcurrent
    :type cl:float
    :initform 0.0)
   (rpm
    :reader rpm
    :initarg :rpm
    :type cl:integer
    :initform 0)
   (count
    :reader count
    :initarg :count
    :type cl:fixnum
    :initform 0))
)

(cl:defclass ESCTelemetryItem (<ESCTelemetryItem>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ESCTelemetryItem>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ESCTelemetryItem)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mavros_msgs-msg:<ESCTelemetryItem> is deprecated: use mavros_msgs-msg:ESCTelemetryItem instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ESCTelemetryItem>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:header-val is deprecated.  Use mavros_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'temperature-val :lambda-list '(m))
(cl:defmethod temperature-val ((m <ESCTelemetryItem>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:temperature-val is deprecated.  Use mavros_msgs-msg:temperature instead.")
  (temperature m))

(cl:ensure-generic-function 'voltage-val :lambda-list '(m))
(cl:defmethod voltage-val ((m <ESCTelemetryItem>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:voltage-val is deprecated.  Use mavros_msgs-msg:voltage instead.")
  (voltage m))

(cl:ensure-generic-function 'current-val :lambda-list '(m))
(cl:defmethod current-val ((m <ESCTelemetryItem>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:current-val is deprecated.  Use mavros_msgs-msg:current instead.")
  (current m))

(cl:ensure-generic-function 'totalcurrent-val :lambda-list '(m))
(cl:defmethod totalcurrent-val ((m <ESCTelemetryItem>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:totalcurrent-val is deprecated.  Use mavros_msgs-msg:totalcurrent instead.")
  (totalcurrent m))

(cl:ensure-generic-function 'rpm-val :lambda-list '(m))
(cl:defmethod rpm-val ((m <ESCTelemetryItem>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:rpm-val is deprecated.  Use mavros_msgs-msg:rpm instead.")
  (rpm m))

(cl:ensure-generic-function 'count-val :lambda-list '(m))
(cl:defmethod count-val ((m <ESCTelemetryItem>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:count-val is deprecated.  Use mavros_msgs-msg:count instead.")
  (count m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ESCTelemetryItem>) ostream)
  "Serializes a message object of type '<ESCTelemetryItem>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'temperature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'voltage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'totalcurrent))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'rpm)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'count)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'count)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ESCTelemetryItem>) istream)
  "Deserializes a message object of type '<ESCTelemetryItem>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'temperature) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'voltage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'current) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'totalcurrent) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'rpm) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'count)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'count)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ESCTelemetryItem>)))
  "Returns string type for a message object of type '<ESCTelemetryItem>"
  "mavros_msgs/ESCTelemetryItem")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ESCTelemetryItem)))
  "Returns string type for a message object of type 'ESCTelemetryItem"
  "mavros_msgs/ESCTelemetryItem")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ESCTelemetryItem>)))
  "Returns md5sum for a message object of type '<ESCTelemetryItem>"
  "a135c5d0c71a3bade75476291a42a6df")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ESCTelemetryItem)))
  "Returns md5sum for a message object of type 'ESCTelemetryItem"
  "a135c5d0c71a3bade75476291a42a6df")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ESCTelemetryItem>)))
  "Returns full string definition for message of type '<ESCTelemetryItem>"
  (cl:format cl:nil "# APM ESC Telemetry as returned by BLHeli~%#~%# See:~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_1_TO_4~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_5_TO_8~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_9_TO_12~%~%std_msgs/Header header~%~%float32 temperature     # deg C~%float32 voltage         # V~%float32 current         # A~%float32 totalcurrent    # Ah~%int32 rpm               # -1/min~%uint16 count            # count of telemetry packets~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ESCTelemetryItem)))
  "Returns full string definition for message of type 'ESCTelemetryItem"
  (cl:format cl:nil "# APM ESC Telemetry as returned by BLHeli~%#~%# See:~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_1_TO_4~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_5_TO_8~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_9_TO_12~%~%std_msgs/Header header~%~%float32 temperature     # deg C~%float32 voltage         # V~%float32 current         # A~%float32 totalcurrent    # Ah~%int32 rpm               # -1/min~%uint16 count            # count of telemetry packets~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ESCTelemetryItem>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ESCTelemetryItem>))
  "Converts a ROS message object to a list"
  (cl:list 'ESCTelemetryItem
    (cl:cons ':header (header msg))
    (cl:cons ':temperature (temperature msg))
    (cl:cons ':voltage (voltage msg))
    (cl:cons ':current (current msg))
    (cl:cons ':totalcurrent (totalcurrent msg))
    (cl:cons ':rpm (rpm msg))
    (cl:cons ':count (count msg))
))
