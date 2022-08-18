; Auto-generated. Do not edit!


(cl:in-package mavros_msgs-msg)


;//! \htmlinclude MagnetometerReporter.msg.html

(cl:defclass <MagnetometerReporter> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (report
    :reader report
    :initarg :report
    :type cl:fixnum
    :initform 0)
   (confidence
    :reader confidence
    :initarg :confidence
    :type cl:float
    :initform 0.0))
)

(cl:defclass MagnetometerReporter (<MagnetometerReporter>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MagnetometerReporter>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MagnetometerReporter)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mavros_msgs-msg:<MagnetometerReporter> is deprecated: use mavros_msgs-msg:MagnetometerReporter instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MagnetometerReporter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:header-val is deprecated.  Use mavros_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'report-val :lambda-list '(m))
(cl:defmethod report-val ((m <MagnetometerReporter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:report-val is deprecated.  Use mavros_msgs-msg:report instead.")
  (report m))

(cl:ensure-generic-function 'confidence-val :lambda-list '(m))
(cl:defmethod confidence-val ((m <MagnetometerReporter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:confidence-val is deprecated.  Use mavros_msgs-msg:confidence instead.")
  (confidence m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MagnetometerReporter>) ostream)
  "Serializes a message object of type '<MagnetometerReporter>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'report)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'confidence))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MagnetometerReporter>) istream)
  "Deserializes a message object of type '<MagnetometerReporter>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'report)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'confidence) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MagnetometerReporter>)))
  "Returns string type for a message object of type '<MagnetometerReporter>"
  "mavros_msgs/MagnetometerReporter")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MagnetometerReporter)))
  "Returns string type for a message object of type 'MagnetometerReporter"
  "mavros_msgs/MagnetometerReporter")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MagnetometerReporter>)))
  "Returns md5sum for a message object of type '<MagnetometerReporter>"
  "c1014202c8f02f171d3d0eef42920a2e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MagnetometerReporter)))
  "Returns md5sum for a message object of type 'MagnetometerReporter"
  "c1014202c8f02f171d3d0eef42920a2e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MagnetometerReporter>)))
  "Returns full string definition for message of type '<MagnetometerReporter>"
  (cl:format cl:nil "std_msgs/Header header~%~%uint8 report~%float32 confidence~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MagnetometerReporter)))
  "Returns full string definition for message of type 'MagnetometerReporter"
  (cl:format cl:nil "std_msgs/Header header~%~%uint8 report~%float32 confidence~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MagnetometerReporter>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MagnetometerReporter>))
  "Converts a ROS message object to a list"
  (cl:list 'MagnetometerReporter
    (cl:cons ':header (header msg))
    (cl:cons ':report (report msg))
    (cl:cons ':confidence (confidence msg))
))
