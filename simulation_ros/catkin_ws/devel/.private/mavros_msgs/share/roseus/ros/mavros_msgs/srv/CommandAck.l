;; Auto-generated. Do not edit!


(when (boundp 'mavros_msgs::CommandAck)
  (if (not (find-package "MAVROS_MSGS"))
    (make-package "MAVROS_MSGS"))
  (shadow 'CommandAck (find-package "MAVROS_MSGS")))
(unless (find-package "MAVROS_MSGS::COMMANDACK")
  (make-package "MAVROS_MSGS::COMMANDACK"))
(unless (find-package "MAVROS_MSGS::COMMANDACKREQUEST")
  (make-package "MAVROS_MSGS::COMMANDACKREQUEST"))
(unless (find-package "MAVROS_MSGS::COMMANDACKRESPONSE")
  (make-package "MAVROS_MSGS::COMMANDACKRESPONSE"))

(in-package "ROS")





(defclass mavros_msgs::CommandAckRequest
  :super ros::object
  :slots (_command _result _progress _result_param2 ))

(defmethod mavros_msgs::CommandAckRequest
  (:init
   (&key
    ((:command __command) 0)
    ((:result __result) 0)
    ((:progress __progress) 0)
    ((:result_param2 __result_param2) 0)
    )
   (send-super :init)
   (setq _command (round __command))
   (setq _result (round __result))
   (setq _progress (round __progress))
   (setq _result_param2 (round __result_param2))
   self)
  (:command
   (&optional __command)
   (if __command (setq _command __command)) _command)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:progress
   (&optional __progress)
   (if __progress (setq _progress __progress)) _progress)
  (:result_param2
   (&optional __result_param2)
   (if __result_param2 (setq _result_param2 __result_param2)) _result_param2)
  (:serialization-length
   ()
   (+
    ;; uint16 _command
    2
    ;; uint8 _result
    1
    ;; uint8 _progress
    1
    ;; uint32 _result_param2
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16 _command
       (write-word _command s)
     ;; uint8 _result
       (write-byte _result s)
     ;; uint8 _progress
       (write-byte _progress s)
     ;; uint32 _result_param2
       (write-long _result_param2 s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16 _command
     (setq _command (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint8 _result
     (setq _result (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _progress
     (setq _progress (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint32 _result_param2
     (setq _result_param2 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass mavros_msgs::CommandAckResponse
  :super ros::object
  :slots (_success _result ))

(defmethod mavros_msgs::CommandAckResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:result __result) 0)
    )
   (send-super :init)
   (setq _success __success)
   (setq _result (round __result))
   self)
  (:success
   (&optional __success)
   (if __success (setq _success __success)) _success)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; uint8 _result
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _result
       (write-byte _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _result
     (setq _result (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass mavros_msgs::CommandAck
  :super ros::object
  :slots ())

(setf (get mavros_msgs::CommandAck :md5sum-) "a3d0814a86c597ac57373d872df6d1d3")
(setf (get mavros_msgs::CommandAck :datatype-) "mavros_msgs/CommandAck")
(setf (get mavros_msgs::CommandAck :request) mavros_msgs::CommandAckRequest)
(setf (get mavros_msgs::CommandAck :response) mavros_msgs::CommandAckResponse)

(defmethod mavros_msgs::CommandAckRequest
  (:response () (instance mavros_msgs::CommandAckResponse :init)))

(setf (get mavros_msgs::CommandAckRequest :md5sum-) "a3d0814a86c597ac57373d872df6d1d3")
(setf (get mavros_msgs::CommandAckRequest :datatype-) "mavros_msgs/CommandAckRequest")
(setf (get mavros_msgs::CommandAckRequest :definition-)
      "# Generic COMMAND_ACK

uint16 command
uint8 result
uint8 progress
uint32 result_param2

---
bool success
# raw result returned by COMMAND_ACK
uint8 result

")

(setf (get mavros_msgs::CommandAckResponse :md5sum-) "a3d0814a86c597ac57373d872df6d1d3")
(setf (get mavros_msgs::CommandAckResponse :datatype-) "mavros_msgs/CommandAckResponse")
(setf (get mavros_msgs::CommandAckResponse :definition-)
      "# Generic COMMAND_ACK

uint16 command
uint8 result
uint8 progress
uint32 result_param2

---
bool success
# raw result returned by COMMAND_ACK
uint8 result

")



(provide :mavros_msgs/CommandAck "a3d0814a86c597ac57373d872df6d1d3")


