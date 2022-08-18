; Auto-generated. Do not edit!


(cl:in-package mavros_msgs-msg)


;//! \htmlinclude Tunnel.msg.html

(cl:defclass <Tunnel> (roslisp-msg-protocol:ros-message)
  ((target_system
    :reader target_system
    :initarg :target_system
    :type cl:fixnum
    :initform 0)
   (target_component
    :reader target_component
    :initarg :target_component
    :type cl:fixnum
    :initform 0)
   (payload_type
    :reader payload_type
    :initarg :payload_type
    :type cl:fixnum
    :initform 0)
   (payload_length
    :reader payload_length
    :initarg :payload_length
    :type cl:fixnum
    :initform 0)
   (payload
    :reader payload
    :initarg :payload
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 128 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass Tunnel (<Tunnel>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Tunnel>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Tunnel)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mavros_msgs-msg:<Tunnel> is deprecated: use mavros_msgs-msg:Tunnel instead.")))

(cl:ensure-generic-function 'target_system-val :lambda-list '(m))
(cl:defmethod target_system-val ((m <Tunnel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:target_system-val is deprecated.  Use mavros_msgs-msg:target_system instead.")
  (target_system m))

(cl:ensure-generic-function 'target_component-val :lambda-list '(m))
(cl:defmethod target_component-val ((m <Tunnel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:target_component-val is deprecated.  Use mavros_msgs-msg:target_component instead.")
  (target_component m))

(cl:ensure-generic-function 'payload_type-val :lambda-list '(m))
(cl:defmethod payload_type-val ((m <Tunnel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:payload_type-val is deprecated.  Use mavros_msgs-msg:payload_type instead.")
  (payload_type m))

(cl:ensure-generic-function 'payload_length-val :lambda-list '(m))
(cl:defmethod payload_length-val ((m <Tunnel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:payload_length-val is deprecated.  Use mavros_msgs-msg:payload_length instead.")
  (payload_length m))

(cl:ensure-generic-function 'payload-val :lambda-list '(m))
(cl:defmethod payload-val ((m <Tunnel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:payload-val is deprecated.  Use mavros_msgs-msg:payload instead.")
  (payload m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Tunnel>)))
    "Constants for message type '<Tunnel>"
  '((:PAYLOAD_TYPE_UNKNOWN . 0)
    (:PAYLOAD_TYPE_STORM32_RESERVED0 . 200)
    (:PAYLOAD_TYPE_STORM32_RESERVED1 . 201)
    (:PAYLOAD_TYPE_STORM32_RESERVED2 . 202)
    (:PAYLOAD_TYPE_STORM32_RESERVED3 . 203)
    (:PAYLOAD_TYPE_STORM32_RESERVED4 . 204)
    (:PAYLOAD_TYPE_STORM32_RESERVED5 . 205)
    (:PAYLOAD_TYPE_STORM32_RESERVED6 . 206)
    (:PAYLOAD_TYPE_STORM32_RESERVED7 . 207)
    (:PAYLOAD_TYPE_STORM32_RESERVED8 . 208)
    (:PAYLOAD_TYPE_STORM32_RESERVED9 . 209))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Tunnel)))
    "Constants for message type 'Tunnel"
  '((:PAYLOAD_TYPE_UNKNOWN . 0)
    (:PAYLOAD_TYPE_STORM32_RESERVED0 . 200)
    (:PAYLOAD_TYPE_STORM32_RESERVED1 . 201)
    (:PAYLOAD_TYPE_STORM32_RESERVED2 . 202)
    (:PAYLOAD_TYPE_STORM32_RESERVED3 . 203)
    (:PAYLOAD_TYPE_STORM32_RESERVED4 . 204)
    (:PAYLOAD_TYPE_STORM32_RESERVED5 . 205)
    (:PAYLOAD_TYPE_STORM32_RESERVED6 . 206)
    (:PAYLOAD_TYPE_STORM32_RESERVED7 . 207)
    (:PAYLOAD_TYPE_STORM32_RESERVED8 . 208)
    (:PAYLOAD_TYPE_STORM32_RESERVED9 . 209))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Tunnel>) ostream)
  "Serializes a message object of type '<Tunnel>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'target_system)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'target_component)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'payload_type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'payload_type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'payload_length)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'payload))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Tunnel>) istream)
  "Deserializes a message object of type '<Tunnel>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'target_system)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'target_component)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'payload_type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'payload_type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'payload_length)) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'payload) (cl:make-array 128))
  (cl:let ((vals (cl:slot-value msg 'payload)))
    (cl:dotimes (i 128)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Tunnel>)))
  "Returns string type for a message object of type '<Tunnel>"
  "mavros_msgs/Tunnel")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Tunnel)))
  "Returns string type for a message object of type 'Tunnel"
  "mavros_msgs/Tunnel")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Tunnel>)))
  "Returns md5sum for a message object of type '<Tunnel>"
  "6d8c215067d3b319bbb219c37c1ebc5d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Tunnel)))
  "Returns md5sum for a message object of type 'Tunnel"
  "6d8c215067d3b319bbb219c37c1ebc5d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Tunnel>)))
  "Returns full string definition for message of type '<Tunnel>"
  (cl:format cl:nil "# Tunnel~%#~%# https://mavlink.io/en/messages/common.html#TUNNEL~%~%uint8 target_system~%uint8 target_component~%uint16 payload_type~%uint8 payload_length~%uint8[128] payload~%~%# [[[cog:~%# from pymavlink.dialects.v20 import common~%#~%# def decl_enum(ename, pfx='', bsz=8):~%#     enum = sorted(common.enums[ename].items())~%#     enum.pop() # remove ENUM_END~%#~%#     cog.outl(\"# \" + ename)~%#     for k, e in enum:~%#         sn = e.name[len(ename) + 1:]~%#         l = \"uint{bsz} {pfx}{sn} = {k}\".format(**locals())~%#         if e.description:~%#             l += ' ' * (40 - len(l)) + ' # ' + e.description~%#         cog.outl(l)~%#~%# decl_enum('MAV_TUNNEL_PAYLOAD_TYPE', 'PAYLOAD_TYPE_', 16)~%# ]]]~%# MAV_TUNNEL_PAYLOAD_TYPE~%uint16 PAYLOAD_TYPE_UNKNOWN = 0          # Encoding of payload unknown.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED0 = 200 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED1 = 201 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED2 = 202 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED3 = 203 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED4 = 204 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED5 = 205 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED6 = 206 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED7 = 207 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED8 = 208 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED9 = 209 # Registered for STorM32 gimbal controller.~%# [[[end]]] (checksum: 3327b212af02c2d47d940cd6de049624)~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Tunnel)))
  "Returns full string definition for message of type 'Tunnel"
  (cl:format cl:nil "# Tunnel~%#~%# https://mavlink.io/en/messages/common.html#TUNNEL~%~%uint8 target_system~%uint8 target_component~%uint16 payload_type~%uint8 payload_length~%uint8[128] payload~%~%# [[[cog:~%# from pymavlink.dialects.v20 import common~%#~%# def decl_enum(ename, pfx='', bsz=8):~%#     enum = sorted(common.enums[ename].items())~%#     enum.pop() # remove ENUM_END~%#~%#     cog.outl(\"# \" + ename)~%#     for k, e in enum:~%#         sn = e.name[len(ename) + 1:]~%#         l = \"uint{bsz} {pfx}{sn} = {k}\".format(**locals())~%#         if e.description:~%#             l += ' ' * (40 - len(l)) + ' # ' + e.description~%#         cog.outl(l)~%#~%# decl_enum('MAV_TUNNEL_PAYLOAD_TYPE', 'PAYLOAD_TYPE_', 16)~%# ]]]~%# MAV_TUNNEL_PAYLOAD_TYPE~%uint16 PAYLOAD_TYPE_UNKNOWN = 0          # Encoding of payload unknown.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED0 = 200 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED1 = 201 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED2 = 202 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED3 = 203 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED4 = 204 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED5 = 205 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED6 = 206 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED7 = 207 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED8 = 208 # Registered for STorM32 gimbal controller.~%uint16 PAYLOAD_TYPE_STORM32_RESERVED9 = 209 # Registered for STorM32 gimbal controller.~%# [[[end]]] (checksum: 3327b212af02c2d47d940cd6de049624)~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Tunnel>))
  (cl:+ 0
     1
     1
     2
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'payload) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Tunnel>))
  "Converts a ROS message object to a list"
  (cl:list 'Tunnel
    (cl:cons ':target_system (target_system msg))
    (cl:cons ':target_component (target_component msg))
    (cl:cons ':payload_type (payload_type msg))
    (cl:cons ':payload_length (payload_length msg))
    (cl:cons ':payload (payload msg))
))
