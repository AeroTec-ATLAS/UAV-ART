;; Auto-generated. Do not edit!


(when (boundp 'mavros_msgs::Tunnel)
  (if (not (find-package "MAVROS_MSGS"))
    (make-package "MAVROS_MSGS"))
  (shadow 'Tunnel (find-package "MAVROS_MSGS")))
(unless (find-package "MAVROS_MSGS::TUNNEL")
  (make-package "MAVROS_MSGS::TUNNEL"))

(in-package "ROS")
;;//! \htmlinclude Tunnel.msg.html


(intern "*PAYLOAD_TYPE_UNKNOWN*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_UNKNOWN* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_UNKNOWN* 0)
(intern "*PAYLOAD_TYPE_STORM32_RESERVED0*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_STORM32_RESERVED0* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_STORM32_RESERVED0* 200)
(intern "*PAYLOAD_TYPE_STORM32_RESERVED1*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_STORM32_RESERVED1* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_STORM32_RESERVED1* 201)
(intern "*PAYLOAD_TYPE_STORM32_RESERVED2*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_STORM32_RESERVED2* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_STORM32_RESERVED2* 202)
(intern "*PAYLOAD_TYPE_STORM32_RESERVED3*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_STORM32_RESERVED3* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_STORM32_RESERVED3* 203)
(intern "*PAYLOAD_TYPE_STORM32_RESERVED4*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_STORM32_RESERVED4* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_STORM32_RESERVED4* 204)
(intern "*PAYLOAD_TYPE_STORM32_RESERVED5*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_STORM32_RESERVED5* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_STORM32_RESERVED5* 205)
(intern "*PAYLOAD_TYPE_STORM32_RESERVED6*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_STORM32_RESERVED6* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_STORM32_RESERVED6* 206)
(intern "*PAYLOAD_TYPE_STORM32_RESERVED7*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_STORM32_RESERVED7* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_STORM32_RESERVED7* 207)
(intern "*PAYLOAD_TYPE_STORM32_RESERVED8*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_STORM32_RESERVED8* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_STORM32_RESERVED8* 208)
(intern "*PAYLOAD_TYPE_STORM32_RESERVED9*" (find-package "MAVROS_MSGS::TUNNEL"))
(shadow '*PAYLOAD_TYPE_STORM32_RESERVED9* (find-package "MAVROS_MSGS::TUNNEL"))
(defconstant mavros_msgs::Tunnel::*PAYLOAD_TYPE_STORM32_RESERVED9* 209)
(defclass mavros_msgs::Tunnel
  :super ros::object
  :slots (_target_system _target_component _payload_type _payload_length _payload ))

(defmethod mavros_msgs::Tunnel
  (:init
   (&key
    ((:target_system __target_system) 0)
    ((:target_component __target_component) 0)
    ((:payload_type __payload_type) 0)
    ((:payload_length __payload_length) 0)
    ((:payload __payload) (make-array 128 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _target_system (round __target_system))
   (setq _target_component (round __target_component))
   (setq _payload_type (round __payload_type))
   (setq _payload_length (round __payload_length))
   (setq _payload __payload)
   self)
  (:target_system
   (&optional __target_system)
   (if __target_system (setq _target_system __target_system)) _target_system)
  (:target_component
   (&optional __target_component)
   (if __target_component (setq _target_component __target_component)) _target_component)
  (:payload_type
   (&optional __payload_type)
   (if __payload_type (setq _payload_type __payload_type)) _payload_type)
  (:payload_length
   (&optional __payload_length)
   (if __payload_length (setq _payload_length __payload_length)) _payload_length)
  (:payload
   (&optional __payload)
   (if __payload (setq _payload __payload)) _payload)
  (:serialization-length
   ()
   (+
    ;; uint8 _target_system
    1
    ;; uint8 _target_component
    1
    ;; uint16 _payload_type
    2
    ;; uint8 _payload_length
    1
    ;; uint8[128] _payload
    (* 1    128)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _target_system
       (write-byte _target_system s)
     ;; uint8 _target_component
       (write-byte _target_component s)
     ;; uint16 _payload_type
       (write-word _payload_type s)
     ;; uint8 _payload_length
       (write-byte _payload_length s)
     ;; uint8[128] _payload
     (princ _payload s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _target_system
     (setq _target_system (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _target_component
     (setq _target_component (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint16 _payload_type
     (setq _payload_type (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint8 _payload_length
     (setq _payload_length (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8[128] _payload
   (setq _payload (make-array 128 :element-type :char))
   (replace _payload buf :start2 ptr-) (incf ptr- 128)
   ;;
   self)
  )

(setf (get mavros_msgs::Tunnel :md5sum-) "6d8c215067d3b319bbb219c37c1ebc5d")
(setf (get mavros_msgs::Tunnel :datatype-) "mavros_msgs/Tunnel")
(setf (get mavros_msgs::Tunnel :definition-)
      "# Tunnel
#
# https://mavlink.io/en/messages/common.html#TUNNEL

uint8 target_system
uint8 target_component
uint16 payload_type
uint8 payload_length
uint8[128] payload

# [[[cog:
# from pymavlink.dialects.v20 import common
#
# def decl_enum(ename, pfx='', bsz=8):
#     enum = sorted(common.enums[ename].items())
#     enum.pop() # remove ENUM_END
#
#     cog.outl(\"# \" + ename)
#     for k, e in enum:
#         sn = e.name[len(ename) + 1:]
#         l = \"uint{bsz} {pfx}{sn} = {k}\".format(**locals())
#         if e.description:
#             l += ' ' * (40 - len(l)) + ' # ' + e.description
#         cog.outl(l)
#
# decl_enum('MAV_TUNNEL_PAYLOAD_TYPE', 'PAYLOAD_TYPE_', 16)
# ]]]
# MAV_TUNNEL_PAYLOAD_TYPE
uint16 PAYLOAD_TYPE_UNKNOWN = 0          # Encoding of payload unknown.
uint16 PAYLOAD_TYPE_STORM32_RESERVED0 = 200 # Registered for STorM32 gimbal controller.
uint16 PAYLOAD_TYPE_STORM32_RESERVED1 = 201 # Registered for STorM32 gimbal controller.
uint16 PAYLOAD_TYPE_STORM32_RESERVED2 = 202 # Registered for STorM32 gimbal controller.
uint16 PAYLOAD_TYPE_STORM32_RESERVED3 = 203 # Registered for STorM32 gimbal controller.
uint16 PAYLOAD_TYPE_STORM32_RESERVED4 = 204 # Registered for STorM32 gimbal controller.
uint16 PAYLOAD_TYPE_STORM32_RESERVED5 = 205 # Registered for STorM32 gimbal controller.
uint16 PAYLOAD_TYPE_STORM32_RESERVED6 = 206 # Registered for STorM32 gimbal controller.
uint16 PAYLOAD_TYPE_STORM32_RESERVED7 = 207 # Registered for STorM32 gimbal controller.
uint16 PAYLOAD_TYPE_STORM32_RESERVED8 = 208 # Registered for STorM32 gimbal controller.
uint16 PAYLOAD_TYPE_STORM32_RESERVED9 = 209 # Registered for STorM32 gimbal controller.
# [[[end]]] (checksum: 3327b212af02c2d47d940cd6de049624)

")



(provide :mavros_msgs/Tunnel "6d8c215067d3b319bbb219c37c1ebc5d")


