; Auto-generated. Do not edit!


(cl:in-package mavros_msgs-srv)


;//! \htmlinclude CommandAck-request.msg.html

(cl:defclass <CommandAck-request> (roslisp-msg-protocol:ros-message)
  ((command
    :reader command
    :initarg :command
    :type cl:fixnum
    :initform 0)
   (result
    :reader result
    :initarg :result
    :type cl:fixnum
    :initform 0)
   (progress
    :reader progress
    :initarg :progress
    :type cl:fixnum
    :initform 0)
   (result_param2
    :reader result_param2
    :initarg :result_param2
    :type cl:integer
    :initform 0))
)

(cl:defclass CommandAck-request (<CommandAck-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CommandAck-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CommandAck-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mavros_msgs-srv:<CommandAck-request> is deprecated: use mavros_msgs-srv:CommandAck-request instead.")))

(cl:ensure-generic-function 'command-val :lambda-list '(m))
(cl:defmethod command-val ((m <CommandAck-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-srv:command-val is deprecated.  Use mavros_msgs-srv:command instead.")
  (command m))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <CommandAck-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-srv:result-val is deprecated.  Use mavros_msgs-srv:result instead.")
  (result m))

(cl:ensure-generic-function 'progress-val :lambda-list '(m))
(cl:defmethod progress-val ((m <CommandAck-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-srv:progress-val is deprecated.  Use mavros_msgs-srv:progress instead.")
  (progress m))

(cl:ensure-generic-function 'result_param2-val :lambda-list '(m))
(cl:defmethod result_param2-val ((m <CommandAck-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-srv:result_param2-val is deprecated.  Use mavros_msgs-srv:result_param2 instead.")
  (result_param2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CommandAck-request>) ostream)
  "Serializes a message object of type '<CommandAck-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'command)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'command)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'result)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'progress)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'result_param2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'result_param2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'result_param2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'result_param2)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CommandAck-request>) istream)
  "Deserializes a message object of type '<CommandAck-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'command)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'command)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'result)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'progress)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'result_param2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'result_param2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'result_param2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'result_param2)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CommandAck-request>)))
  "Returns string type for a service object of type '<CommandAck-request>"
  "mavros_msgs/CommandAckRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CommandAck-request)))
  "Returns string type for a service object of type 'CommandAck-request"
  "mavros_msgs/CommandAckRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CommandAck-request>)))
  "Returns md5sum for a message object of type '<CommandAck-request>"
  "a3d0814a86c597ac57373d872df6d1d3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CommandAck-request)))
  "Returns md5sum for a message object of type 'CommandAck-request"
  "a3d0814a86c597ac57373d872df6d1d3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CommandAck-request>)))
  "Returns full string definition for message of type '<CommandAck-request>"
  (cl:format cl:nil "# Generic COMMAND_ACK~%~%uint16 command~%uint8 result~%uint8 progress~%uint32 result_param2~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CommandAck-request)))
  "Returns full string definition for message of type 'CommandAck-request"
  (cl:format cl:nil "# Generic COMMAND_ACK~%~%uint16 command~%uint8 result~%uint8 progress~%uint32 result_param2~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CommandAck-request>))
  (cl:+ 0
     2
     1
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CommandAck-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CommandAck-request
    (cl:cons ':command (command msg))
    (cl:cons ':result (result msg))
    (cl:cons ':progress (progress msg))
    (cl:cons ':result_param2 (result_param2 msg))
))
;//! \htmlinclude CommandAck-response.msg.html

(cl:defclass <CommandAck-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (result
    :reader result
    :initarg :result
    :type cl:fixnum
    :initform 0))
)

(cl:defclass CommandAck-response (<CommandAck-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CommandAck-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CommandAck-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mavros_msgs-srv:<CommandAck-response> is deprecated: use mavros_msgs-srv:CommandAck-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <CommandAck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-srv:success-val is deprecated.  Use mavros_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <CommandAck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-srv:result-val is deprecated.  Use mavros_msgs-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CommandAck-response>) ostream)
  "Serializes a message object of type '<CommandAck-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'result)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CommandAck-response>) istream)
  "Deserializes a message object of type '<CommandAck-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'result)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CommandAck-response>)))
  "Returns string type for a service object of type '<CommandAck-response>"
  "mavros_msgs/CommandAckResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CommandAck-response)))
  "Returns string type for a service object of type 'CommandAck-response"
  "mavros_msgs/CommandAckResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CommandAck-response>)))
  "Returns md5sum for a message object of type '<CommandAck-response>"
  "a3d0814a86c597ac57373d872df6d1d3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CommandAck-response)))
  "Returns md5sum for a message object of type 'CommandAck-response"
  "a3d0814a86c597ac57373d872df6d1d3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CommandAck-response>)))
  "Returns full string definition for message of type '<CommandAck-response>"
  (cl:format cl:nil "bool success~%# raw result returned by COMMAND_ACK~%uint8 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CommandAck-response)))
  "Returns full string definition for message of type 'CommandAck-response"
  (cl:format cl:nil "bool success~%# raw result returned by COMMAND_ACK~%uint8 result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CommandAck-response>))
  (cl:+ 0
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CommandAck-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CommandAck-response
    (cl:cons ':success (success msg))
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CommandAck)))
  'CommandAck-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CommandAck)))
  'CommandAck-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CommandAck)))
  "Returns string type for a service object of type '<CommandAck>"
  "mavros_msgs/CommandAck")