; Auto-generated. Do not edit!


(cl:in-package mavros_msgs-msg)


;//! \htmlinclude ESCTelemetry.msg.html

(cl:defclass <ESCTelemetry> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (esc_telemetry
    :reader esc_telemetry
    :initarg :esc_telemetry
    :type (cl:vector mavros_msgs-msg:ESCTelemetryItem)
   :initform (cl:make-array 0 :element-type 'mavros_msgs-msg:ESCTelemetryItem :initial-element (cl:make-instance 'mavros_msgs-msg:ESCTelemetryItem))))
)

(cl:defclass ESCTelemetry (<ESCTelemetry>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ESCTelemetry>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ESCTelemetry)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mavros_msgs-msg:<ESCTelemetry> is deprecated: use mavros_msgs-msg:ESCTelemetry instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ESCTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:header-val is deprecated.  Use mavros_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'esc_telemetry-val :lambda-list '(m))
(cl:defmethod esc_telemetry-val ((m <ESCTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:esc_telemetry-val is deprecated.  Use mavros_msgs-msg:esc_telemetry instead.")
  (esc_telemetry m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ESCTelemetry>) ostream)
  "Serializes a message object of type '<ESCTelemetry>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'esc_telemetry))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'esc_telemetry))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ESCTelemetry>) istream)
  "Deserializes a message object of type '<ESCTelemetry>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'esc_telemetry) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'esc_telemetry)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'mavros_msgs-msg:ESCTelemetryItem))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ESCTelemetry>)))
  "Returns string type for a message object of type '<ESCTelemetry>"
  "mavros_msgs/ESCTelemetry")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ESCTelemetry)))
  "Returns string type for a message object of type 'ESCTelemetry"
  "mavros_msgs/ESCTelemetry")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ESCTelemetry>)))
  "Returns md5sum for a message object of type '<ESCTelemetry>"
  "7b1fb252ca6aa175fe8dd23d029b3362")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ESCTelemetry)))
  "Returns md5sum for a message object of type 'ESCTelemetry"
  "7b1fb252ca6aa175fe8dd23d029b3362")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ESCTelemetry>)))
  "Returns full string definition for message of type '<ESCTelemetry>"
  (cl:format cl:nil "# APM ESC Telemetry as returned by BLHeli~%#~%# See:~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_1_TO_4~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_5_TO_8~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_9_TO_12~%~%std_msgs/Header header~%~%mavros_msgs/ESCTelemetryItem[] esc_telemetry~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: mavros_msgs/ESCTelemetryItem~%# APM ESC Telemetry as returned by BLHeli~%#~%# See:~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_1_TO_4~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_5_TO_8~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_9_TO_12~%~%std_msgs/Header header~%~%float32 temperature     # deg C~%float32 voltage         # V~%float32 current         # A~%float32 totalcurrent    # Ah~%int32 rpm               # -1/min~%uint16 count            # count of telemetry packets~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ESCTelemetry)))
  "Returns full string definition for message of type 'ESCTelemetry"
  (cl:format cl:nil "# APM ESC Telemetry as returned by BLHeli~%#~%# See:~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_1_TO_4~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_5_TO_8~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_9_TO_12~%~%std_msgs/Header header~%~%mavros_msgs/ESCTelemetryItem[] esc_telemetry~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: mavros_msgs/ESCTelemetryItem~%# APM ESC Telemetry as returned by BLHeli~%#~%# See:~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_1_TO_4~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_5_TO_8~%# https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_9_TO_12~%~%std_msgs/Header header~%~%float32 temperature     # deg C~%float32 voltage         # V~%float32 current         # A~%float32 totalcurrent    # Ah~%int32 rpm               # -1/min~%uint16 count            # count of telemetry packets~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ESCTelemetry>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'esc_telemetry) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ESCTelemetry>))
  "Converts a ROS message object to a list"
  (cl:list 'ESCTelemetry
    (cl:cons ':header (header msg))
    (cl:cons ':esc_telemetry (esc_telemetry msg))
))
